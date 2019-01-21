//
//  AbstractLayer.cpp
//  lib
//
//  Created by mengxk on 2018/12/28.
//  Copyright © 2018 Elastos. All rights reserved.
//

#include "AbstractLayer.hpp"

#include <Elastos.SDK.Keypair.C/Elastos.Wallet.Utility.h>

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

char* AbstractLayer_GenerateRawTransaction(const char* transaction)
{
	char* rawTx = generateRawTransaction(transaction);
	return rawTx;
}

void AbstractLayer_FreeBuf(void* buf)
{
	freeBuf(buf);
}
