//
//  ElastosWallet.swift
//  lib
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

public final class ElastosWallet  {
  private init() {}
  
  public static func GenerateMnemonic(language: String, path: String) -> String? {
    let languagePtr = String.ToUnsafeMutablePointer(data: language)
    let pathPtr = String.ToUnsafeMutablePointer(data: path)
    
    let mnemonicPtr = generateMnemonic(languagePtr, pathPtr)
    
    let mnemonic = String.FromUnsafeMutablePointer(data: mnemonicPtr)
    
    return mnemonic
  }
  
  public static func GetAddress(publicKey: String) -> String? {
    let pubKeyPtr = String.ToUnsafeMutablePointer(data: publicKey)
    
    let addressPtr = getAddress(pubKeyPtr)
    
    let address = String.FromUnsafeMutablePointer(data: addressPtr)
    
    return address
  }
  
  public static func GetPublicKey(privateKey: String) -> String? {
    let privKeyPtr = String.ToUnsafeMutablePointer(data: privateKey)
    
    let pubKeyPtr = getPublicKey(privKeyPtr)
    
    let pubKey = String.FromUnsafeMutablePointer(data: pubKeyPtr)
    
    return pubKey
  }
  
  public static func GetMasterPrivateKey(mmemonic: String, language: String,
                                  path: String, password: String) -> String? {
    let mmemonicPtr = String.ToUnsafeMutablePointer(data: mmemonic)
    let languagePtr = String.ToUnsafeMutablePointer(data: language)
    let pathPtr = String.ToUnsafeMutablePointer(data: path)
    let passwordPtr = String.ToUnsafeMutablePointer(data: password)
    
    let privKeyPtr = getMasterPrivateKey(mmemonicPtr, languagePtr,
                                         pathPtr, passwordPtr)
    
    let privKey = String.FromUnsafeMutablePointer(data: privKeyPtr)
    
    return privKey
  }
  
  public static func GenerateRawTransaction(transaction: String) -> String? {
    let transactionPtr = String.ToUnsafeMutablePointer(data: transaction)
    
    let rawTxPtr = generateRawTransaction(transactionPtr)
    
    let rawTx = String.FromUnsafeMutablePointer(data: rawTxPtr)
    
    return rawTx
  }

}
