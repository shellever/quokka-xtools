#include <stdio.h>  // sprintf
#include <stdint.h> // uint8_t
#include <ctype.h>  // toupper
#include <string.h> // memcpy

#include "utils.h"


// byte array to hex string
// {0x13, 0x14} -> "1314"
void ByteArrayToHexString(const unsigned char *pByteArray, char *pHexString, int iByteArrayLen)
{
    int i;
    unsigned char byteHigh, byteLow;

    for (i = 0; i < iByteArrayLen; i++) {
        byteHigh = pByteArray[i] >> 4;
        byteLow  = pByteArray[i] & 0x0F;

        if (byteHigh > 9) {
            pHexString[i * 2] = byteHigh - 10 + 'A';
        } else {
            pHexString[i * 2] = byteHigh + '0';
        }

        if (byteLow > 9) {
            pHexString[i * 2 + 1] = byteLow - 10 + 'A';
        } else {
            pHexString[i * 2 + 1] = byteLow + '0';
        }
    }
}

// hex string to byte array
void ByteArrayToHexString2(const unsigned char *pByteArray, char *pHexString, int iByteArrayLen)
{
    int  i;
    char strBuffer[3];

    for (i = 0; i < iByteArrayLen; i++) {
        sprintf(strBuffer, "%02X", pByteArray[i]);
        memcpy(&pHexString[i * 2], strBuffer, 2);
    }
}

// hex string to byte array
// "1314" -> {0x13, 0x14}
void HexStringToByteArray(const char *pHexString, unsigned char *pByteArray, int iHexStringLen)
{
    int i;
    unsigned char byteHigh, byteLow;

    for (i = 0; i < iHexStringLen; i += 2) {
        byteHigh = toupper(pHexString[i]);
        byteLow  = toupper(pHexString[i + 1]);

        if (byteHigh > '9') {
            byteHigh = byteHigh - 'A' + 10;
        } else {
            byteHigh = byteHigh - '0';
        }

        if (byteLow > '9') {
            byteLow = byteLow - 'A' + 10;
        } else {
            byteLow = byteLow - '0';
        }

        pByteArray[i / 2] = (byteHigh << 4) | byteLow;
    }
}


