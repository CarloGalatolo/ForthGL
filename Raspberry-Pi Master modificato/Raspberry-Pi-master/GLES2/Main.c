#include <stdbool.h>			// Neede for bool
#include <stdint.h>				// Needed for uint32_t, uint16_t etc
#include <string.h>				// Needed for memcpy
#include "emb-stdio.h"			// Needed for printf
#include "rpi-smartstart.h"		// Needed for smart start API 
#include "rpi-GLES.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <wchar.h> 
#include <wctype.h> 

#define v3d ((volatile __attribute__((aligned(4))) uint32_t*)(uintptr_t)(RPi_IO_Base_Addr + 0xc00000))

// be865b13
// be865000

static uint32_t shader1[18] = {  // Vertex Color Shader
		0x958e0dbf, 0xd1724823,   /* mov r0, vary; mov r3.8d, 1.0 */
		0x818e7176, 0x40024821,   /* fadd r0, r0, r5; mov r1, vary */
        0x818e7376, 0x10024862,   /* fadd r1, r1, r5; mov r2, vary */
		0x819e7540, 0x114248a3,   /* fadd r2, r2, r5; mov r3.8a, r0 */
	    0x809e7009, 0x115049e3,   /* nop; mov r3.8b, r1 */
		0x809e7012, 0x116049e3,   /* nop; mov r3.8c, r2 */
		0x159e76c0, 0x30020ba7,   /* mov tlbc, r3; nop; thrend */
		0x009e7000, 0x100009e7,   /* nop; nop; nop */
		0x009e7000, 0x500009e7,   /* nop; nop; sbdone */
};

static uint32_t shader2[12] = { // Fill Color Shader
		0x009E7000, 0x100009E7,   // nop; nop; nop
		0xFFFFFFFF,	0xE0020BA7,	  // ldi tlbc, RGBA White
		0x009E7000, 0x500009E7,   // nop; nop; sbdone
		0x009E7000, 0x300009E7,   // nop; nop; thrend
		0x009E7000, 0x100009E7,   // nop; nop; nop
		0x009E7000, 0x100009E7,   // nop; nop; nop
};

static RENDER_STRUCT scene = { 0 };

int main (void) {

	//FILE *ptr;
	//ptr = fopen("test.bin","wb");
	//if(!ptr){

	
	//FILE *v3d_init_file;
	//v3d_init_file = open("./v3d_init_file.txt","w");

 /* if (!v3d_init_file) // equivalent to saying if ( in_file == NULL ) 
             {  
                printf("oops, file can't be read\n"); 
           
             } 
			 else{*/
	Init_EmbStdio(Embedded_Console_WriteChar);						// Initialize embedded stdio
	PiConsole_Init(1280, 720, 32, printf);							// Auto resolution console, message to screen
	displaySmartStart(printf);										// Display smart start details
	ARM_setmaxspeed(printf);										// ARM CPU to max speed no message to screen
	InitV3D();														// Initialize 3D graphics

	// Step1: Initialize scene
	V3D_InitializeScene(&scene, GetConsole_Width(), GetConsole_Height());

	// Step2: Add vertexes to scene
	V3D_AddVertexesToScene(&scene);

	// Step3: Add shader to scene
	V3D_AddShadderToScene(&scene, &shader1[0], _countof(shader1));
	
	// Step4: Setup render control
	V3D_SetupRenderControl(&scene, GetConsole_FrameBuffer());
	
	// Step5: Setup binning
	V3D_SetupBinningConfig(&scene);

	printf("Render DAta VC4:%x \n",scene.rendererDataVC4);
    // Step 6: Render the scene
	//V3D_RenderScene(&scene);

	printf("All done batman .. we have triangles\n");
	//printf("RPi_IO_base_address: %x\n", v3d);
	//printf("scene.loadpos finale: %x\n", scene.loadpos);
	//printf("Indirizzo di scene prima di V3D_AddVertexesToScene %x\n", scene.loadpos_copy);(uint8_t*)v3d[0x108>>2]
/*	uint8_t* i = (uint8_t*)v3d[0x110>>2], *j = i;

	for ( ; i != j + 40; i += 1)
	{
		printf("Per i = %x, valore: %x\n", i, *i);
	}
	//printf("*v3d[0x110>>2] = %x\n", *(uint8_t*)GPUaddrToARMaddr(v3d[0x108>>2]-1));
*/
	/*
	// int i = 0;
	for (int i = 0; i < 4; i++)
	{
		printf("Indirizzo di scene dopo le operazioni con la maschera, tmp %d: %x\n", i, scene.tmp[i]);
		printf("Indirizzo tradotto da GPU ad ARM tcp %d: %x\n", i, scene.tcp[i]);
		// printf("dummy %d: %x\n", i, scene.dummy[i]);
	}
	*/
	//printf("scene->binningDataVC4: %x\nscene->binningCfgEnd: %x\nscene->renderControlVC4: %x\nscene->renderControlEndVC4: %x\n", (uint8_t)*(scene.dummy[0]), (uint8_t)*(scene.dummy[1]), (uint8_t)*(scene.dummy[2]), (uint8_t)*(scene.dummy[3]));
	//printf("scene->tileDataBufferVC4 = %x\nscene->tileDataBufferVC4 + (y * scene->binWth + x) * 32 = %x\nOffset = %x\n", scene.banana[0], scene.banana[1], scene.banana[1] - scene.banana[0]);
	
	while (1){
		set_Activity_LED(1);			// Turn LED on
		timer_wait(500000);	// 0.5 sec delay
		set_Activity_LED(0);			// Turn Led off
		timer_wait(500000);   // 0.5 sec delay
    }

	// Release resources
	//V3D_mem_unlock(handle);
	//V3D_mem_free(handle);
	return(0);
}
