// --------------------------------------------------------------------
// Copyright (c) 2010 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------

#include "terasic_includes.h"
#include "WaveLib.h"

#define TAG_RIFF  0x46464952  // little-endin "RIFF"
#define TAG_WAVE  0x45564157  // little-endin "WAVE"
#define CHUNK_FORMAT 0x20746D66 // little-endin "fmt "
#define CHUNK_DATA 0x61746164   // little-endin "data"

//#pragma pack(push, 1)
#pragma pack(1)

typedef struct{
    alt_u32 ID;
    alt_u32 Size;
}CHUNK;

typedef struct{
    alt_u32 ID;
    alt_u32 Size;
    alt_u16  AudioFormat;
    alt_u16 NumChannels;
    alt_u32 SampleRate;
    alt_u32 ByteRate;
    alt_u16 BlockAlign;
    alt_u16 BitsPerSample;
}PCM_FORMAT_CHUNK;

typedef struct {
    alt_u32 ChunkID;
    alt_u32 ChunkSize;
    alt_u32 Format;
}WAVE_HEADER;

//#pragma pack(pop)
#pragma pack()

int waveGetChunkOffset(char *szWave, const int nSize, const unsigned int ChunkID);
int waveGetChunkOffset(char *szWave, const int nSize, const unsigned int ChunkID){
        int nNum = 0;
        if (nSize >= sizeof(WAVE_HEADER)){
                int nOffset = sizeof(WAVE_HEADER);
                CHUNK *pChunk = (CHUNK *)(szWave+nOffset);
                while ((pChunk->ID != ChunkID) && nOffset < nSize){
                        int nSkip = sizeof(CHUNK) + pChunk->Size;
                        pChunk = (CHUNK *)((alt_u8 *)pChunk + nSkip);
                        nOffset += nSkip;
                }
                if (pChunk->ID == ChunkID)
                        nNum = nOffset;
        }
        return nNum;
}

bool WAVE_IsWaveFile(char *szWave, const int nSize){
        bool bYes = FALSE;
        if (nSize >= sizeof(WAVE_HEADER)){
                WAVE_HEADER *pHeader = (WAVE_HEADER *)szWave;
                if ((pHeader->ChunkID == TAG_RIFF) && (pHeader->Format == TAG_WAVE)){
                        int nOffset = waveGetChunkOffset(szWave, nSize, CHUNK_FORMAT);
                        if (nOffset){
                                PCM_FORMAT_CHUNK *pPcmChunk = (PCM_FORMAT_CHUNK *)(szWave+nOffset);
                                if (pPcmChunk->Size == 16 && pPcmChunk->AudioFormat == 1){ // uncompress PCM
                                        bYes = TRUE;
                                }
                        }
                }

        }
        return bYes;
}

int Wave_GetSampleRate(char *szWave, const int nSize){
        int nNum = 0;
        int nOffset = waveGetChunkOffset(szWave, nSize, CHUNK_FORMAT);
        if (nOffset){
               PCM_FORMAT_CHUNK *pPcmChunk = (PCM_FORMAT_CHUNK *)(szWave+nOffset);
               nNum = pPcmChunk->SampleRate;
        }
        return nNum;

}

int Wave_GetChannelNum(char *szWave, const int nSize){
        int nNum = 0;
        int nOffset = waveGetChunkOffset(szWave, nSize, CHUNK_FORMAT);
        if (nOffset){
               PCM_FORMAT_CHUNK *pPcmChunk = (PCM_FORMAT_CHUNK *)(szWave+nOffset);
               nNum = pPcmChunk->NumChannels;
        }
        return nNum;
}

int Wave_GetSampleBitNum(char *szWave, const int nSize){
        int nNum = 0;
        int nOffset = waveGetChunkOffset(szWave, nSize, CHUNK_FORMAT);
        if (nOffset){
               PCM_FORMAT_CHUNK *pPcmChunk = (PCM_FORMAT_CHUNK *)(szWave+nOffset);
               nNum = pPcmChunk->BitsPerSample;
        }
        return nNum;
}



int Wave_GetDataByteSize(char *szWave, const int nSize){
    int nNum = 0;
    int nOffset;
    nOffset = waveGetChunkOffset(szWave, nSize, CHUNK_DATA);
    if (nOffset){
            CHUNK *pChunk = (CHUNK *)(szWave+nOffset);
            nNum = pChunk->Size;
    }
    return nNum;
}

int Wave_GetWaveOffset(char *szWave, const int nSize){
        int nNum = 0;
        int nOffset;
        nOffset = waveGetChunkOffset(szWave, nSize, CHUNK_DATA);
        if (nOffset)
                nNum = nOffset + sizeof(CHUNK);
        return nNum;

}
