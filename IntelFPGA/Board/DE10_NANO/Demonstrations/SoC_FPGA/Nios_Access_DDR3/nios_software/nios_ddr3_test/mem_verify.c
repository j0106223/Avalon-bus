/*
 * memory_verify.c
 *
 *  Created on: Dec 31, 2014
 *      Author: matthew
 */
#include "terasic_includes.h"
#include "mem_verify.h"

bool TMEM_Verify(alt_u32 BaseAddr, alt_u32 ByteLen, alt_u32 InitValue, bool bShowMessage){
    bool bPass = TRUE;
    typedef alt_u32 my_data;
    my_data szData[257];
    int i, nRemainedLen, nAccessLen;
    my_data *pDes, *pSrc;
    int nItemNum, nPos;
    const int my_data_size = sizeof(my_data);
    int nProgressIndex=0;
    alt_u32 szProgress[10];

    if (bShowMessage){
        for(i=0;i<10;i++){
            szProgress[i] = ByteLen/10*(i+1);
        }
    }

    nItemNum = sizeof(szData)/sizeof(szData[0]);
    for(i=0;i<nItemNum;i++){
        if (i == 0)
            szData[i] = InitValue;
        else
            szData[i] = szData[i-1] * 13;
    }
    szData[nItemNum-1] = 0xAAAAAAAA;
    szData[nItemNum-2] = 0x55555555;
    szData[nItemNum-3] = 0x00000000;
    szData[nItemNum-4] = 0xFFFFFFFF;

    if (bShowMessage)
        printf("write...\n");
    // write
    pDes = (my_data *)BaseAddr;
    nAccessLen = sizeof(szData);
    nItemNum = nAccessLen / my_data_size;
    nPos = 0;
    while(nPos < ByteLen){
        nRemainedLen = ByteLen - nPos;
        if (nAccessLen > nRemainedLen){
            nAccessLen = nRemainedLen;
            nItemNum = nAccessLen / my_data_size;
        }
        memcpy(pDes, szData, nAccessLen);
        pDes += nItemNum;
        nPos += nAccessLen;

        if (bShowMessage){
            if (nProgressIndex <= 9 && nPos >= szProgress[nProgressIndex]){
                nProgressIndex++;
                printf("%02d%% ", nProgressIndex*10);
            }
        }
    }

    alt_dcache_flush_all();

    if (bShowMessage){
        nProgressIndex = 0;
        printf("\nread/verify...\n");
    }

    // read & verify
    pSrc = (my_data *)BaseAddr;
    nAccessLen = sizeof(szData);
    nItemNum = nAccessLen / my_data_size;
    nPos = 0;
    while(bPass && nPos < ByteLen){
        nRemainedLen = ByteLen - nPos;
        if (nAccessLen > nRemainedLen){
            nAccessLen = nRemainedLen;
            nItemNum = nAccessLen / my_data_size;
        }
        pDes = szData;
        for(i=0;i<nItemNum && bPass;i++){
            if (*pSrc++ != *pDes++){
                if (bShowMessage)
                    printf("verify ng,address==%08Xh, read=%08Xh, expected=%08Xh, WordIndex=%Xh\n",pSrc-1, (int)*(pSrc-1), (int)szData[i], (nPos/my_data_size)+i);
                bPass = FALSE;
            }
        }
        nPos += nAccessLen;
        if (bShowMessage){
            if (nProgressIndex <= 9 && nPos >= szProgress[nProgressIndex]){
                nProgressIndex++;
                printf("%02d%% ", nProgressIndex*10);
            }
        }
    }

    if (bShowMessage)
        printf("\n");

    return bPass;
}

