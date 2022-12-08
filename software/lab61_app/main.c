// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng
//#include <stdint.h>


int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x70; //make a pointer to access the PIO block
	volatile unsigned int *SW_PIO = (unsigned int*)0x60;
	volatile unsigned int *ACCUM_PIO = (unsigned int*)0x50;
	volatile unsigned int sum = 0x0;
	volatile unsigned int prev_accum = 0x1;
	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		if(*ACCUM_PIO == 0x0 && prev_accum == 0x1){
			sum += *SW_PIO;
			*LED_PIO = sum;
		}
		prev_accum = *ACCUM_PIO;
		for (i = 0; i < 1000; i++); //software delay

//		if(*ACCUM_PIO == 0x0){
//			sum += *SW_PIO;
//			while(*ACCUM_PIO == 0x0){
//				*LED_PIO = sum;
//			}
//		}

//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO |= 0x1; //set LSB
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO &= ~0x1; //clear LSB
	}
	return 1; //never gets here
}
