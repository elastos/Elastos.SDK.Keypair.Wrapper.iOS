//
//  AbstractLayer.hpp
//  lib
//
//  Created by mengxk on 2018/12/28.
//  Copyright © 2018 Elastos. All rights reserved.
//

#ifndef AbstractLayer_hpp
#define AbstractLayer_hpp

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

char* AbstractLayer_GenerateMnemonic(const char* language, const char* words);

int AbstractLayer_GetSeedFromMnemonic(void** seed, const char* mnemonic, const char* language, const char* words, const char* mnemonicPassword);

char* AbstractLayer_GetSinglePublicKey(const void* seed, int seedLen);

char* AbstractLayer_GetSinglePrivateKey(const void* seed, int seedLen);

char* AbstractLayer_GetPublicKeyFromPrivateKey(const char* privateKey);
  
char* AbstractLayer_GetAddress(const char* publicKey);

bool AbstractLayer_IsAddressValid(const char* address);

char* AbstractLayer_GetDid(const char* publicKey);

int AbstractLayer_Sign(const char* privateKey, const void* data, int len, void** signedData);

bool AbstractLayer_Verify(const char* publicKey, const void* data, int len, const void* signedData, int signedLen);

char* AbstractLayer_GenerateRawTransaction(const char* transaction);

char** AbstractLayer_GetSignedSigners(const char* transaction, int* outLen);

char* AbstractLayer_EciesEncrypt(const char* publicKey, const char* plainText);

char* AbstractLayer_EciesDecrypt(const char* privateKey, const char* cipherText);

void AbstractLayer_FreeBuf(void* buf);

#ifdef __cplusplus
}
#endif

#endif /* AbstractLayer_hpp */
