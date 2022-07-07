/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2020 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "board.h"
#include "music.h"
#include "pin_mux.h"
#include "clock_config.h"

#include "fsl_dmamux.h"
#include "fsl_sai_edma.h"
#include "fsl_iomuxc.h"
#include "fsl_debug_console.h"

/*******************************************************************************
 * Definitions
 ******************************************************************************/
/* SAI instance and clock */
#define DEMO_SAI SAI3

/* Select Audio PLL (786.432 MHz) as sai1 clock source */
#define DEMO_SAI_CLOCK_SOURCE_SELECT (2U)
/* Clock pre divider for sai clock source */
#define DEMO_SAI_CLOCK_SOURCE_PRE_DIVIDER (3U)
/* Clock divider for sai clock source */
#define DEMO_SAI_CLOCK_SOURCE_DIVIDER (1U)
/* Get frequency of sai clock: SAI3_Clock = 786.432MHz /(3+1)/(1+1) = 98.304MHz */
#define DEMO_SAI_CLK_FREQ (CLOCK_GetFreq(kCLOCK_AudioPllClk) / (DEMO_SAI_CLOCK_SOURCE_DIVIDER + 1U) / (DEMO_SAI_CLOCK_SOURCE_PRE_DIVIDER + 1U))

/* DMA */
#define DEMO_DMA           DMA0
#define DEMO_EDMA_CHANNEL  (0U)
#define DEMO_SAI_TX_SOURCE kDmaRequestMuxSai3Tx
/*******************************************************************************
 * Prototypes
 ******************************************************************************/
static void callback(I2S_Type *base, sai_edma_handle_t *handle, status_t status, void *userData);

/*******************************************************************************
 * Variables
 ******************************************************************************/
/*
 * AUDIO PLL setting: Frequency = Fref * (DIV_SELECT + NUM / DENOM)
 *                              = 24 * (32 + 768/1000)
 *                              = 786.432 MHz
 */
const clock_audio_pll_config_t audioPllConfig = {
    .loopDivider = 32,  /* PLL loop divider. Valid range for DIV_SELECT divider value: 27~54. */
    .postDivider = 1,   /* Divider after the PLL, should only be 1, 2, 4, 8, 16. */
    .numerator = 768,   /* 30 bit numerator of fractional loop divider. */
    .denominator = 1000,/* 30 bit denominator of fractional loop divider */
};
AT_NONCACHEABLE_SECTION_INIT(sai_edma_handle_t txHandle) = {0};
edma_handle_t g_dmaHandle                                = {0};
volatile bool isFinished      = false;
/*******************************************************************************
 * Code
 ******************************************************************************/


static void callback(I2S_Type *base, sai_edma_handle_t *handle, status_t status, void *userData)
{
    isFinished = true;
}

void configMQS(void)
{
    CCM->CCGR0 = CCM->CCGR0 & (~CCM_CCGR0_CG2_MASK) | CCM_CCGR0_CG2(3);         /* Enable MQS hmclk. */

    IOMUXC_MQSEnterSoftwareReset(IOMUXC_GPR, true);                             /* Reset MQS. */
    IOMUXC_MQSEnterSoftwareReset(IOMUXC_GPR, false);                            /* Release reset MQS. */
    IOMUXC_MQSEnable(IOMUXC_GPR, true);                                         /* Enable MQS. */
    IOMUXC_MQSConfig(IOMUXC_GPR, kIOMUXC_MqsPwmOverSampleRate64, 0u);           /* 98.304MHz/64/(0+1) = 1.536MHz
                                                                                Higher frequency PWM involves less low frequency harmonic.*/
}

/*!
 * @brief Main function
 */
int main(void)
{
    sai_transfer_t xfer;
    edma_config_t dmaConfig = {0};
    sai_transceiver_t config;

    BOARD_ConfigMPU();
    BOARD_InitPins();
    BOARD_BootClockRUN();
    CLOCK_InitAudioPll(&audioPllConfig);
    BOARD_InitDebugConsole();

    /*Clock setting for SAI. */
    CLOCK_SetMux(kCLOCK_Sai3Mux, DEMO_SAI_CLOCK_SOURCE_SELECT);
    CLOCK_SetDiv(kCLOCK_Sai3PreDiv, DEMO_SAI_CLOCK_SOURCE_PRE_DIVIDER);
    CLOCK_SetDiv(kCLOCK_Sai3Div, DEMO_SAI_CLOCK_SOURCE_DIVIDER);

    DMAMUX_Init(DMAMUX);
    DMAMUX_SetSource(DMAMUX, DEMO_EDMA_CHANNEL, DEMO_SAI_TX_SOURCE);
    DMAMUX_EnableChannel(DMAMUX, DEMO_EDMA_CHANNEL);

    PRINTF("SAI MQS DMA example started.\n\r");

    /* Create EDMA handle */
    EDMA_GetDefaultConfig(&dmaConfig);
    EDMA_Init(DEMO_DMA, &dmaConfig);
    EDMA_CreateHandle(&g_dmaHandle, DEMO_DMA, DEMO_EDMA_CHANNEL);

    /* SAI init */
    SAI_Init(DEMO_SAI);

    SAI_TransferTxCreateHandleEDMA(DEMO_SAI, &txHandle, callback, NULL, &g_dmaHandle);

    /* I2S mode configurations */
    SAI_GetClassicI2SConfig(&config, kSAI_WordWidth16bits, kSAI_Stereo, 1U << 0u);
    config.frameSync.frameSyncEarly = false;
    config.frameSync.frameSyncPolarity = kSAI_PolarityActiveHigh;
    SAI_TransferTxSetConfigEDMA(DEMO_SAI, &txHandle, &config);
    /* set bit clock divider */
    SAI_TxSetBitClockRate(DEMO_SAI, DEMO_SAI_CLK_FREQ, kSAI_SampleRate16KHz, kSAI_WordWidth16bits, 2u);

    configMQS();

    /*  xfer structure */
    xfer.data = (uint8_t *)(uint32_t)music;
    xfer.dataSize = MUSIC_LEN;

    while (1)
    {
        isFinished = false;
        SAI_TransferSendEDMA(DEMO_SAI, &txHandle, &xfer);
        /* Wait until finished */
        while (isFinished != true)
        {
        }
    }
}
