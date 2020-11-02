//
//  ElastosKeypairFileCoin.swift
//  lib
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

import Foundation

open class ElastosKeypairFileCoin {
  private init() {}
  
  
  public static func GetSinglePublicKey(seed: Data, seedLen: Int) -> String? {
    let pubKey = AbstractLayer.FileCoin.GetSinglePublicKey(seed: seed, seedLen: seedLen)
    return pubKey
  }
  
  public static func GetSinglePrivateKey(seed: Data, seedLen: Int) -> String? {
    let privKey = AbstractLayer.FileCoin.GetSinglePrivateKey(seed: seed, seedLen: seedLen)
    return privKey
  }
  
  public static func GetPublicKeyFromPrivateKey(privateKey: String) -> String? {
    let pubKey = AbstractLayer.FileCoin.GetPublicKeyFromPrivateKey(privateKey: privateKey)
    return pubKey
  }
  
  public static func GetAddress(publicKey: String) -> String? {
    let address = AbstractLayer.FileCoin.GetAddress(publicKey: publicKey)
    return address
  }
  
  public static func IsAddressValid(address: String) -> Bool {
    let valid = AbstractLayer.FileCoin.IsAddressValid(address: address)
    return valid
  }
  
  public static func Sign(privateKey: String?, data: Data, len: Int, signedData: inout Data) -> Int {
    let signedDataLen = AbstractLayer.FileCoin.Sign(privateKey: privateKey,
                                                    data: data,
                                                    len: len,
                                                    signedData: &signedData)
    
    return signedDataLen
  }
    
  public static func Verify(publicKey: String?, data: Data, len: Int, signedData:Data,signedLen:Int) -> Bool {
    let verifyResult = AbstractLayer.FileCoin.Verify(publicKey: publicKey,
                                                     data: data,
                                                     len: len,
                                                     signedData: signedData,
                                                     signedLen: signedLen)

    return verifyResult
  }
  
  
  public static func GenerateRawTransaction(privateKey: String?, transaction: String) -> String? {
    let rawTx = AbstractLayer.FileCoin.GenerateRawTransaction(privateKey: privateKey, transaction: transaction)
    return rawTx
  }
}
