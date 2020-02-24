//
//  ViewController.swift
//  test
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

import UIKit

import ElastosSdkKeypair

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let seed = testGenrateMnemonic()
    let (privKeys, pubKeys) = testHDWalletAddress(seed: seed!)
    testDid(privKeys: privKeys, pubKeys: pubKeys)
    testSignTxData()
    testCosignTxData()
    testCrypto()
  }


}

func testGenrateMnemonic() -> Data? {
  print("============= start testGenrateMnemonic ===========")

  var mnemonic = ElastosKeypair.GenerateMnemonic(language: "english", words: "")
  print("mnemonic: \(mnemonic)")
  
  var seed = Data()
  let seedLen = ElastosKeypair.GetSeedFromMnemonic(seed: &seed,
                                                   mnemonic: mnemonic!,
                                                   mnemonicPassword: "")
  let seedStr = seed.hexEncodedString()
  print("seedStr: \(seedStr) seedLen: \(seedLen)")
  
  
  let privKey = ElastosKeypair.GetSinglePrivateKey(seed: seed, seedLen: seedLen)!
  print("privKey: \(privKey)")
  let pubKey = ElastosKeypair.GetSinglePublicKey(seed: seed, seedLen: seedLen)
  print("pubKey: \(pubKey)")
  let pubKeyVerify = ElastosKeypair.GetPublicKeyFromPrivateKey(privateKey: privKey)
  print(pubKeyVerify)
  assert(pubKeyVerify == pubKey)
  
  let address = ElastosKeypair.GetAddress(publicKey: pubKey!)
  print("address: \(address)")
  
  let data = Data([0, 1, 2, 3, 4, 5])
  var signedData = Data()
  let signedLen = ElastosKeypair.Sign(privateKey: privKey, data: data, len: data.count, signedData: &signedData)
  print("signedLen: \(signedLen)")
  
  let verified = ElastosKeypair.Verify(publicKey: pubKey, data: data, len: data.count, signedData: signedData, signedLen: signedData.count)
  print("verified: \(verified)")
  
  print("============= end testGenrateMnemonic ===========")
  
  return seed
}

func testHDWalletAddress(seed: Data) -> ([String?], [String?]) {
  print("============= start testHDWalletAddress ===========")
  
  let masterPubKey = ElastosKeypairHD.GetMasterPublicKey(seed: seed, seedLen: seed.count, coinType: ElastosKeypairHD.COIN_TYPE_ELA);
  print("masterPubKey: \(masterPubKey)")
  
  let count = 10
  var privateKeys = [String?](repeating: nil, count: count)
  var publicKeys = [String?](repeating: nil, count: count)
  var addresses = [String?](repeating: nil, count: count)
  for idx in 0..<count {
    privateKeys[idx] = ElastosKeypairHD.GenerateSubPrivateKey(seed: seed, seedLen: seed.count, coinType: ElastosKeypairHD.COIN_TYPE_ELA, chain: ElastosKeypairHD.EXTERNAL_CHAIN, index: idx)
    publicKeys[idx] = ElastosKeypairHD.GenerateSubPublicKey(masterPublicKey: masterPubKey!, chain: ElastosKeypairHD.EXTERNAL_CHAIN, index: idx);
    addresses[idx] = ElastosKeypair.GetAddress(publicKey: publicKeys[idx]!);
    
    print("private key \(idx): \(privateKeys[idx])")
    print("public key \(idx): \(publicKeys[idx])")
    print("address \(idx): \(addresses[idx])")
  }
  
  print("============= end testHDWalletAddress ===========")

  return (privateKeys, publicKeys)
}

func testDid(privKeys: [String?], pubKeys: [String?]) {
  print("============= start testDID ===========")

  let count = privKeys.count
  var dids = [String?](repeating: nil, count: count)
  for idx in 0..<count {
    dids[idx] = ElastosKeypairDID.GetDid(publicKey: pubKeys[idx]!);

    print("did \(idx): \(dids[idx])")
  }
  
  print("============= end testDID ===========")
}

func testSignTxData() {
  print("============= start testSignTxData ===========")
  
  let transaction = "{\"Transactions\":[{\"UTXOInputs\":[{"
                  + "\"txid\":\"f176d04e5980828770acadcfc3e2d471885ab7358cd7d03f4f61a9cd0c593d54\","
                  + "\"privateKey\":\"b6f010250b6430b2dd0650c42f243d5445f2044a9c2b6975150d8b0608c33bae\","
                  + "\"index\":0,\"address\":\"EeniFrrhuFgQXRrQXsiM1V4Amdsk4vfkVc\"}],"
                  + "\"Outputs\":[{\"address\":\"EbxU18T3M9ufnrkRY7NLt6sKyckDW4VAsA\","
                  + "\"amount\":2000000}]}]}";
  var rawTx = ElastosKeypairSign.GenerateRawTransaction(transaction: transaction)
  print("rawTx: \(rawTx)")
  
  rawTx = ElastosKeypairSign.GenerateRawTransaction(transaction: transaction, assertId: nil)
  
  print("============= end testSignTxData ===========")
}

func testCosignTxData() {
  print("============= start testCosignTxData ===========")
  
  let data = "{\"Transactions\":[{\"UTXOInputs\":[{"
           + "\"txid\":\"c20d577997a6036683e1a88925eaa4c2e4ca2f34db95a3fe85ad3787da017bec\","
           + "\"index\":0,\"address\":\"8NJ7dbKsG2NRiBqdhY6LyKMiWp166cFBiG\"}],"
           + "\"Outputs\":[{\"address\":\"EbxU18T3M9ufnrkRY7NLt6sKyckDW4VAsA\","
           + "\"amount\":2000000}]}]}";
  
  let publicKeys = [
    "031ed85c1a56e912de5562657c6d6a03cfe974aab8b62d484cea7f090dac9ff1cf",
    "0306ee2fa3fb66e21b61ac1af9ce95271d9bb5fc902f92bd9ff6333bda552ebc64",
    "03b8d95fa2a863dcbd44bf288040df4c6cb9d674a61c4c1e3638ac515994c777e5"
  ]
  
  let private1 = "79b442f402a50c1f3026edfa160a6555c0f9c48a86d85ab103809008a913f07b";
  let private2 = "37878ce7b4b509aee357996a7d0a0e0e478759be034503b7b6438356d2200973";
  let private3 = "0c2e640e0e025d58f6630a0fecea2419f26bb7fea6c67cd9c32aa4f1116ef74e";

  let address = ElastosKeypairSign.GetMultiSignAddress(publicKeys: publicKeys, length: 3, requiredSignCount: 2)
  print("cosign address: \(address)")
  
  let signedData1 = ElastosKeypairSign.MultiSignTransaction(privateKey: private2, publicKeys: publicKeys, length: 3,
                                                            requiredSignCount: 2, transaction: data)
  print("signed data1: \(signedData1)")
  let signedData2 = ElastosKeypairSign.MultiSignTransaction(privateKey: private3, publicKeys: publicKeys, length: 3,
                                                            requiredSignCount: 2, transaction: signedData1!)
  print("signed data2: \(signedData2)")
  
  var signerCount: Int = 0;
  let signerArray = ElastosKeypairSign.GetSignedSigners(transaction: signedData2!, outLen: &signerCount);
  if (signerArray != nil) {
    for idx in 0..<signerArray!.count {
      print("signed public key: \(signerArray![idx])");
    }
  }

  let serialize = ElastosKeypairSign.SerializeMultiSignTransaction(transaction: signedData2!);
  print("serialize data: \(serialize)");
  
  print("============= end testCosignTxData ===========")
}

func testCrypto() {
  print("============= start testCrypto ===========")
  
  let pubKey = "02bc11aa5c35acda6f6f219b94742dd9a93c1d11c579f98f7e3da05ad910a48306"
  let privKey = "543c241f89bebb660157bcd12d7ab67cf69f3158240a808b22eb98447bad205d"
  
  let originText = "Hello World!!!"
  print("originText: \(originText)")
  let cipherText = ElastosKeypairCrypto.EciesEncrypt(publicKey: pubKey, plainText: originText.data(using: .utf8)!)
  print("cipherText: \(cipherText)")
  let plainText = ElastosKeypairCrypto.EciesDecrypt(privateKey: privKey, cipherText: cipherText!)
  let str = String(decoding: plainText!, as: UTF8.self)
  print("plainText: \(str)")
  assert(originText == str)
  
  print("============= end testCrypto ===========")
}

extension Data {
  func hexEncodedString() -> String {
    return map { String(format: "%02hhX", $0) }.joined()
  }
}
