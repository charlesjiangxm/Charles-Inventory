/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xExample.h"
#include "xExample_hw.h"
#include "xil_cache.h"
#include "xtime_l.h"

int main()
{
	XTime tEnd,tCur;
	u32 tUsed;
    init_platform();

    printf("program starts\n");

    // set up ddr pointer
    unsigned int *src;
    src = (unsigned int *) XPAR_PSU_DDR_1_S_AXI_BASEADDR;

    unsigned int *dest;
    dest = (unsigned int *) XPAR_PSU_DDR_1_S_AXI_BASEADDR + 0x01000000;

    // initialize the data
    printf("start writing to src\n");
    for(int i=0; i < 196608*(128/32); i++) {
    	src[i] = i;
    }
    printf("end writing to src\n");

    // configuration
    XExample HlsXExample;
    XExample_Config *ExamplePtr;
    printf("Look Up the device configuration.\n");
    ExamplePtr = XExample_LookupConfig(XPAR_EXAMPLE_0_DEVICE_ID);
    if (!ExamplePtr) {
    	printf("ERROR: Lookup of accelerator configuration failed.\n\r");
    	return XST_FAILURE;
    }

    // initialization
    printf("Initialize the Device\n");
    long status = XExample_CfgInitialize(&HlsXExample, ExamplePtr);
    if (status != XST_SUCCESS) {
    printf("ERROR: Could not initialize accelerator.\n\r");
    	return(-1);
    }

    // set the block input
    printf("start setting up the device init data\n");
    XExample_Set_data_in_V(&HlsXExample, (u32)src);
    printf("end setting up the device init data\n");

    // start the block
    XTime_GetTime(&tCur);


    XExample_Start(&HlsXExample);
    while (XExample_IsDone(&HlsXExample) == 0);


    XTime_GetTime(&tEnd);
    tUsed=((tEnd-tCur)*1000000)/(COUNTS_PER_SECOND);
    printf("time used is %d us\n",tUsed);

    cleanup_platform();
    return 0;
}

