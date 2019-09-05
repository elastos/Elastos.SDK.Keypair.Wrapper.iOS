//
//  AbstractLayer.swift
//  lib
//
//  Created by mengxk on 2018/12/28.
//  Copyright © 2018 Elastos. All rights reserved.
//

import Foundation

open class AbstractLayer {
  private init() {}

  public static func GenerateMnemonic(language: String, words: String?) -> String? {
    let languagePtr = String.ToUnsafeMutablePointer(data: language)
      let wordsPtr = String.ToUnsafeMutablePointer(data: words)

      let mnemonicPtr = AbstractLayer_GenerateMnemonic(languagePtr, wordsPtr)
      let mnemonic = String.FromUnsafeMutablePointer(data: mnemonicPtr)
      AbstractLayer_FreeBuf(mnemonicPtr)

      return mnemonic
  }

  public static func GetSeedFromMnemonic(seed: inout Data,
      mnemonic: String?,
      mnemonicPassword: String) -> Int {
    guard mnemonic != nil else { return -1 }

    let mnemonicPtr = String.ToUnsafeMutablePointer(data: mnemonic)
    let mnemonicPasswordPtr = String.ToUnsafeMutablePointer(data: mnemonicPassword)

    var seedPtr: UnsafeMutableRawPointer? = nil
    let seedLen = AbstractLayer_GetSeedFromMnemonic(&seedPtr, mnemonicPtr, mnemonicPasswordPtr)
    guard seedLen > 0 && seedPtr != nil else {
      return Int(seedLen)
    }

    let seedData = Data.FromUnsafeMutablePointer(data: seedPtr, size: Int(seedLen))
      AbstractLayer_FreeBuf(seedPtr)

//      let seedStr = seedData?.base64EncodedString()
//      print( "======================" + seedStr! )

      seed.removeAll()
      seed.append(seedData!)

      return Int(seedLen)
  }

  public static func GetSinglePublicKey(seed: Data?, seedLen: Int) -> String? {
    guard seed != nil else { return nil }
    let seedPtr = Data.ToUnsafeMutablePointer(data: seed)

      let pubKeyPtr = AbstractLayer_GetSinglePublicKey(seedPtr, Int32(seedLen))
      let pubKey = String.FromUnsafeMutablePointer(data: pubKeyPtr)
      AbstractLayer_FreeBuf(pubKeyPtr)

      return pubKey
  }

  public static func GetSinglePrivateKey(seed: Data?, seedLen: Int) -> String? {
    guard seed != nil else { return nil }
    let seedPtr = Data.ToUnsafeMutablePointer(data: seed)

      let privKeyPtr = AbstractLayer_GetSinglePrivateKey(seedPtr, Int32(seedLen))
      let privKey = String.FromUnsafeMutablePointer(data: privKeyPtr)
      AbstractLayer_FreeBuf(privKeyPtr)

      return privKey
  }


  public static func GetPublicKeyFromPrivateKey(privateKey: String?) -> String? {
    guard privateKey != nil else { return nil }

    let privKeyPtr = String.ToUnsafeMutablePointer(data: privateKey)

      let pubKeyPtr = AbstractLayer_GetPublicKeyFromPrivateKey(privKeyPtr)

      let pubKey = String.FromUnsafeMutablePointer(data: pubKeyPtr)

      return pubKey
  }

  public static func GetAddress(publicKey: String?) -> String? {
    guard publicKey != nil else { return nil }
    let pubKeyPtr = String.ToUnsafeMutablePointer(data: publicKey)

      let addressPtr = AbstractLayer_GetAddress(pubKeyPtr)
      let address = String.FromUnsafeMutablePointer(data: addressPtr)
      AbstractLayer_FreeBuf(addressPtr)

      return address
  }

  public static func IsAddressValid(address: String?) -> Bool {
    guard address != nil else { return false }
    let addressPtr = String.ToUnsafeMutablePointer(data: address)
    
    let validPtr = AbstractLayer_IsAddressValid(addressPtr)
    
    return validPtr
  }
  
  public static func GetDid(publicKey: String?) -> String? {
    guard publicKey != nil else { return nil }
    let pubKeyPtr = String.ToUnsafeMutablePointer(data: publicKey)
    
    let didPtr = AbstractLayer_GetDid(pubKeyPtr)
    let did = String.FromUnsafeMutablePointer(data: didPtr)
    AbstractLayer_FreeBuf(didPtr)
    
    return did
  }
  
  public static func Sign(privateKey: String?, data: Data, len: Int, signedData: inout Data) -> Int {
    guard privateKey != nil else { return -1 }

    let privateKeyPtr = String.ToUnsafeMutablePointer(data: privateKey)
      let dataPtr = Data.ToUnsafeMutablePointer(data: data)

      var signedDataPtr: UnsafeMutableRawPointer? = nil
      let signedDataLen = AbstractLayer_Sign(privateKeyPtr, dataPtr, Int32(len), &signedDataPtr)
      guard signedDataLen > 0 && signedDataPtr != nil else {
        return Int(signedDataLen)
      }

    let signedDataData = Data.FromUnsafeMutablePointer(data: signedDataPtr!, size: Int(signedDataLen))
      AbstractLayer_FreeBuf(signedDataPtr)

      signedData.removeAll()
      signedData.append(signedDataData!)

      return Int(signedDataLen)
  }

  public static func GetMasterPublicKey(seed: Data?, seedLen: Int32, coinType: Int32, masterPubKeyLen: inout Int32) -> Data? {
    guard seed != nil else { return nil }
    let seedPtr = Data.ToUnsafeMutablePointer(data: seed)
    
    let masterPubKeyPtr = AbstractLayer_GetMasterPublicKey(seedPtr, seedLen, coinType,
                                                           &masterPubKeyLen)
    
    let masterPubKey = Data.FromUnsafeMutablePointer(data: masterPubKeyPtr, size: Int(masterPubKeyLen))
    AbstractLayer_FreeBuf(masterPubKeyPtr)
    
    return masterPubKey
  }
  
  public static func GenerateSubPrivateKey(seed: Data?, seedLen: Int32,
                                           coinType: Int32, chain: Int32, index: Int32) -> String? {
    guard seed != nil else { return nil }
    let seedPtr = Data.ToUnsafeMutablePointer(data: seed)
    
    let subPrivKeyPtr = AbstractLayer_GenerateSubPrivateKey(seedPtr, seedLen, coinType, chain, index)
    
    let subPrivKey = String.FromUnsafeMutablePointer(data: subPrivKeyPtr)
    AbstractLayer_FreeBuf(subPrivKeyPtr)

    return subPrivKey
  }
  
  public static func GenerateSubPublicKey(masterPublicKey: Data?, chain: Int32, index: Int32) -> String?
  {
    guard masterPublicKey != nil else { return nil }
    let masterPublicKeyPtr = Data.ToUnsafeMutablePointer(data: masterPublicKey)
    
    let subPubKeyPtr = AbstractLayer_GenerateSubPublicKey(masterPublicKeyPtr, chain, index)
    
    let subPubKey = String.FromUnsafeMutablePointer(data: subPubKeyPtr)
    AbstractLayer_FreeBuf(subPubKeyPtr)
    
    return subPubKey
  }
  
  public static func GenerateRawTransaction(transaction: String, assertId: String? = nil) -> String? {
    let transactionPtr = String.ToUnsafeMutablePointer(data: transaction)
    let assertIdPtr = String.ToUnsafeMutablePointer(data: assertId)

      let rawTxPtr = AbstractLayer_GenerateRawTransaction(transactionPtr, assertIdPtr)

      let rawTx = String.FromUnsafeMutablePointer(data: rawTxPtr)
      AbstractLayer_FreeBuf(rawTxPtr)

      return rawTx
  }
    
  public static func Verify(publicKey: String?, data: Data, len: Int, signedData:Data,signedLen:Int) -> Bool {
        
        guard publicKey != nil else { return false }
        let pubKeyPtr = String.ToUnsafeMutablePointer(data: publicKey)
        let dataPtr = Data.ToUnsafeMutablePointer(data: data)
        let signedDataPtr = Data.ToUnsafeMutablePointer(data: signedData)
        
        let signedResult = AbstractLayer_Verify(publicKey, dataPtr, Int32(len), signedDataPtr,Int32(signedLen))
        
        AbstractLayer_FreeBuf(pubKeyPtr)
        AbstractLayer_FreeBuf(dataPtr)
        AbstractLayer_FreeBuf(signedDataPtr)
        
        return Bool(signedResult)
  }

  public static func GetMultiSignAddress(publicKeys: [String]?, length: Int32,
                                         requiredSignCount: Int32) -> String? {
    let publicKeysPtr = String.ToUnsafeMutablePointer(array: publicKeys)
    
    let multiSignAddrPtr = AbstractLayer_GetMultiSignAddress(publicKeysPtr, length, requiredSignCount)
    
    let multiSignAddr = String.FromUnsafeMutablePointer(data: multiSignAddrPtr)
    AbstractLayer_FreeBuf(multiSignAddrPtr)
    
    return multiSignAddr
  }
  
  public static func MultiSignTransaction(privateKey: String, publicKeys: [String], length: Int32,
                                          requiredSignCount: Int32,
                                          transaction: String) -> String? {
    let privateKeyPtr = String.ToUnsafeMutablePointer(data: privateKey)
    let publicKeysPtr = String.ToUnsafeMutablePointer(array: publicKeys)
    let transactionPtr = String.ToUnsafeMutablePointer(data: transaction)
    
    let multiSignTxPtr = AbstractLayer_MultiSignTransaction(privateKeyPtr, publicKeysPtr,
                                                            length, requiredSignCount,
                                                            transactionPtr)
    
    let multiSignTx = String.FromUnsafeMutablePointer(data: multiSignTxPtr)
    AbstractLayer_FreeBuf(multiSignTxPtr)
    
    return multiSignTx
  }
  
  public static func SerializeMultiSignTransaction(transaction: String) -> String? {
    let transactionPtr = String.ToUnsafeMutablePointer(data: transaction)
    
    let retPtr = AbstractLayer_SerializeMultiSignTransaction(transactionPtr)
    
    let ret = String.FromUnsafeMutablePointer(data: retPtr)
    AbstractLayer_FreeBuf(retPtr)
    
    return ret
  }
  
  public static func GetSignedSigners(transaction: String, outLen: inout Int32) -> [String]? {
    let transactionPtr = String.ToUnsafeMutablePointer(data: transaction)
    
    var signerArrayPtr = AbstractLayer_GetSignedSigners(transactionPtr, &outLen)
    if(signerArrayPtr == nil) {
      return nil
    }
    
    let signerArray = String.FromUnsafeMutablePointer(array: signerArrayPtr, len: Int(outLen))
    for _ in 0..<outLen {
      AbstractLayer_FreeBuf(signerArrayPtr?.pointee)
      signerArrayPtr? += 1
    }
    //AbstractLayer_FreeStringArray(signerArrayPtr) // TODO: memory leak
    
    return signerArray
  }
  
  public static func EciesEncrypt(publicKey: String, plainText: String) -> String? {
    let publicKeyPtr = String.ToUnsafeMutablePointer(data: publicKey)
    let plainTextPtr = String.ToUnsafeMutablePointer(data: plainText)
    
    let retPtr = AbstractLayer_EciesEncrypt(publicKeyPtr, plainTextPtr)
    
    let ret = String.FromUnsafeMutablePointer(data: retPtr)
    AbstractLayer_FreeBuf(retPtr)

    return ret
  }
  
  public static func EciesDecrypt(privateKey: String, cipherText: String) -> String? {
    let privateKeyPtr = String.ToUnsafeMutablePointer(data: privateKey)
    let cipherTextPtr = String.ToUnsafeMutablePointer(data: cipherText)
    
    let retPtr = AbstractLayer_EciesDecrypt(privateKeyPtr, cipherTextPtr)
    
    let ret = String.FromUnsafeMutablePointer(data: retPtr)
    AbstractLayer_FreeBuf(retPtr)
    
    return ret
  }
}
