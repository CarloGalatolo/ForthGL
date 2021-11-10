#include <stdio.h>
#include <stdlib.h>

int processFile(char* fileName, char* buffer, int bufferIndex);

int main(){
	int fileno = 13;
	char* fileNames[fileno];
	FILE *outputFile;
	char* outputFileName = "Complete.forth";
	char* buffer = malloc(100000);
	int bufferIndex = 0;
	
	outputFile = fopen(outputFileName,"w");
	fileNames[0] = "Initialize.forth";
	fileNames[1] = "Framebuffer.forth";
	fileNames[2] = "SetMaxClock.forth";
	fileNames[3] = "InitV3D.forth";
	fileNames[4] = "TileMemAlloc.forth";
	fileNames[5] = "BinAlloc.forth";
	fileNames[6] = "V3DMemAlloc.forth";
	fileNames[7] = "Emit.forth";
	fileNames[8] = "AddPoint.forth";
	fileNames[9] = "AddShade.forth";
	fileNames[10] = "SetupRender.forth";
	fileNames[11] = "Bin_Fine.forth";
	fileNames[12] = "RenderScene.forth";
	
	for(int i=0 ; i < fileno ; i++){
		bufferIndex = processFile(fileNames[i], buffer, bufferIndex);
	}
	buffer[bufferIndex] = '\n';
	fprintf(outputFile, buffer);
	fclose(outputFile);
	return 0;
}

int processFile(char* fileName, char* buffer, int bufferIndex){
	FILE *file;
	file = fopen(fileName, "r");
	char c;
	int spaceFound = 0;
	int waitForNewLine = 0;

	while (1)
	{
		c = getc(file);

		if(c == EOF) break;
		
		if (c == '\\') 
		{
			waitForNewLine = 1 ;
		}
		else {
			if(c == '\n') {
				c = ' ' ;
				waitForNewLine = 0;
			}
			if(!waitForNewLine){
				if(c == ' ' || c == '\t') {
					spaceFound++ ;
				} else spaceFound = 0;
			}
		}
		if(!waitForNewLine && spaceFound <= 1 ){
			buffer[bufferIndex] = c;
			bufferIndex++;
		}
	}
	fclose(file);
	return bufferIndex;
}
