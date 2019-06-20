//
//  AbstractLayer.cpp
//  lib
//
//  Created by mengxk on 2018/12/28.
//  Copyright © 2018 Elastos. All rights reserved.
//

#include "AbstractLayer.hpp"

#include <Elastos.SDK.Keypair.C/Elastos.Wallet.Utility.h>
#include <memory>

char* AbstractLayer_GenerateMnemonic(const char* language, const char* words)
{
	char* mnemonic = generateMnemonic(language, words);
	return mnemonic;
}

int AbstractLayer_GetSeedFromMnemonic(void** seed,
								      const char* mnemonic,
									  const char* language,
									  const char* words,
									  const char* mnemonicPassword)
{
	int ret = getSeedFromMnemonic(seed, mnemonic, language, words, mnemonicPassword);
	return ret;
}

char* AbstractLayer_GetSinglePublicKey(const void* seed, int seedLen)
{
	char* pubkey = getSinglePublicKey(seed, seedLen);
	return pubkey;
}

char* AbstractLayer_GetSinglePrivateKey(const void* seed, int seedLen)
{
	char* privkey = getSinglePrivateKey(seed, seedLen);
	return privkey;
}

char* AbstractLayer_GetPublicKeyFromPrivateKey(const char* privateKey)
{
  char* pubkey = getPublicKeyFromPrivateKey(privateKey);
  return pubkey;
}

char* AbstractLayer_GetAddress(const char* publicKey)
{
	char* address = getAddress(publicKey);
	return address;
}

bool AbstractLayer_IsAddressValid(const char* address)
{
	bool valid = isAddressValid(address);
	return valid;
}

char* AbstractLayer_GetDid(const char* publicKey)
{
	char* did = getDid(publicKey);
	return did;
}

int AbstractLayer_Sign(const char* privateKey, const void* data, int len,
					   void** signedData)
{
	int ret = sign(privateKey, data, len, signedData);
	return ret;
}

bool AbstractLayer_Verify(const char* publicKey, const void* data, int len,
						  const void* signedData, int signedLen)
{
	bool valid = verify(publicKey, data, len, signedData, signedLen);
	return valid;
}

char* AbstractLayer_GenerateRawTransaction(const char* transaction, const char* assertId)
{
	char* rawTx = generateRawTransaction(transaction, assertId);
	return rawTx;
}

void* AbstractLayer_GetMasterPublicKey(const void* seed, int seedLen, int coinType,
                                       int* masterPubKeyLen)
{
  MasterPublicKey* masterPubKey = getMasterPublicKey(seed, seedLen, coinType);
  *masterPubKeyLen = sizeof(MasterPublicKey);
  return masterPubKey;
}

char* AbstractLayer_GenerateSubPrivateKey(const void* seed, int seedLen, int coinType,
                                          int chain, int index)
{
  char* subPrivKey = generateSubPrivateKey(seed, seedLen, coinType, chain, index);
  return subPrivKey;
}

char* AbstractLayer_GenerateSubPublicKey(const void* masterPublicKey, int chain, int index)
{
  char * subPubKey = generateSubPublicKey(reinterpret_cast<const MasterPublicKey *>(masterPublicKey),
                                          chain, index);
  return subPubKey;
}

char* AbstractLayer_GetMultiSignAddress(char** publicKeys, int length, int requiredSignCount)
{
  char* address = getMultiSignAddress(publicKeys, length, requiredSignCount);
  return address;
}

char* AbstractLayer_MultiSignTransaction(const char* privateKey, char** publicKeys,
                                         int length, int requiredSignCount,
                                         const char* transaction)
{
  char* multiSignTx = multiSignTransaction(privateKey, publicKeys, length, requiredSignCount, transaction);
  return multiSignTx;
}

char* AbstractLayer_SerializeMultiSignTransaction(const char* transaction)
{
  char* ret = serializeMultiSignTransaction(transaction);
  return ret;
}

char** AbstractLayer_GetSignedSigners(const char* transaction, int* outLen)
{
  char** ret = getSignedSigners(transaction, outLen);
  return ret;
}

char* AbstractLayer_EciesEncrypt(const char* publicKey, const char* plainText)
{
  char* ret = eciesEncrypt(publicKey, plainText);
  return ret;
}

char* AbstractLayer_EciesDecrypt(const char* privateKey, const char* cipherText)
{
  int len;
  char* ret = eciesDecrypt(privateKey, cipherText, &len);
  return ret;
}

void AbstractLayer_FreeBuf(void* buf)
{
	freeBuf(buf);
}

void AbstractLayer_FreeStringArray(char** buf)
{
  free(buf);
}
