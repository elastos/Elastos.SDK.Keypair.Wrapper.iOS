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
      language: String, words: String?,
      mnemonicPassword: String) -> Int {
    guard mnemonic != nil else { return -1 }

    let mnemonicPtr = String.ToUnsafeMutablePointer(data: mnemonic)
      let languagePtr = String.ToUnsafeMutablePointer(data: language)
      let wordsPtr = String.ToUnsafeMutablePointer(data: words)
      let mnemonicPasswordPtr = String.ToUnsafeMutablePointer(data: mnemonicPassword)

      var seedPtr: UnsafeMutableRawPointer? = nil
      let seedLen = AbstractLayer_GetSeedFromMnemonic(&seedPtr, mnemonicPtr, languagePtr, wordsPtr, mnemonicPasswordPtr)
      guard seedLen > 0 && seedPtr != nil else {
        return Int(seedLen)
      }

    let seedData = Data.FromUnsafeMutablePointer(data: seedPtr, size: Int(seedLen))
      AbstractLayer_FreeBuf(seedPtr)

      let seedStr = seedData?.base64EncodedString()
      print( "======================" + seedStr! )

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

  public static func GenerateRawTransaction(transaction: String) -> String? {
    let transactionPtr = String.ToUnsafeMutablePointer(data: transaction)

      let rawTxPtr = AbstractLayer_GenerateRawTransaction(transactionPtr)

      let rawTx = String.FromUnsafeMutablePointer(data: rawTxPtr)

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
}
