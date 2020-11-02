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

int AbstractLayer_GetSeedFromMnemonic(void** seed, const char* mnemonic, const char* mnemonicPassword);

char* AbstractLayer_GetSinglePublicKey(const void* seed, int seedLen);

char* AbstractLayer_GetSinglePrivateKey(const void* seed, int seedLen);

char* AbstractLayer_GetPublicKeyFromPrivateKey(const char* privateKey);
  
char* AbstractLayer_GetAddress(const char* publicKey);

char* AbstractLayer_GetAddressByInfo(const char* info);

bool AbstractLayer_IsAddressValid(const char* address);

char* AbstractLayer_GetDid(const char* publicKey);

char* AbstractLayer_GetDidByInfo(const char* info);

int AbstractLayer_Sign(const char* privateKey, const void* data, int len, void** signedData);

bool AbstractLayer_Verify(const char* publicKey, const void* data, int len, const void* signedData, int signedLen);

char* AbstractLayer_GenerateRawTransaction(const char* transaction, const char* assertId);

void* AbstractLayer_GetMasterPublicKey(const void* seed, int seedLen, int coinType, int* masterPubKeyLen);

char* AbstractLayer_GenerateSubPrivateKey(const void* seed, int seedLen, int coinType, int chain, int index);

char* AbstractLayer_GenerateSubPublicKey(const void* masterPublicKey, int chain, int index);

char* AbstractLayer_GetMultiSignAddress(char** publicKeys, int length, int requiredSignCount);
  
char* AbstractLayer_MultiSignTransaction(const char* privateKey, char** publicKeys,
                                         int length, int requiredSignCount,
                                         const char* transaction);

char* AbstractLayer_SerializeMultiSignTransaction(const char* transaction);

char** AbstractLayer_GetSignedSigners(const char* transaction, int* outLen);

char* AbstractLayer_EciesEncrypt(const char* publicKey, const unsigned char* plainText, int len);

unsigned char* AbstractLayer_EciesDecrypt(const char* privateKey, const char* cipherText, int* outLen);

void AbstractLayer_FreeBuf(void* buf);

void AbstractLayer_FreeStringArray(char** buf);
  
char* AbstractLayer_FileCoin_GetSinglePublicKey(const void* seed, int seedLen);

char* AbstractLayer_FileCoin_GetSinglePrivateKey(const void* seed, int seedLen);

char* AbstractLayer_FileCoin_GetPublicKeyFromPrivateKey(const char* privateKey);

char* AbstractLayer_FileCoin_GetAddress(const char* publicKey);

bool AbstractLayer_FileCoin_IsAddressValid(const char* address);

int AbstractLayer_FileCoin_Sign(const char* privateKey, const void* data, int len,
                                void** signedData);

bool AbstractLayer_FileCoin_Verify(const char* publicKey, const void* data, int len,
                                   const void* signedData, int signedLen);

char* AbstractLayer_FileCoin_GenerateRawTransaction(const char* privateKey, const char* transaction);


#ifdef __cplusplus
}
#endif

#endif /* AbstractLayer_hpp */
