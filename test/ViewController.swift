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

    let listArray = ["get Mnemonic","get single priv","get publickey","get address","Sign","verrify","getDid"]

    @IBOutlet weak var UITableView: UITableView!


    let mnemonic = Utility.GenerateMnemonic(language: "zh")

    var privKey : String {
        get{
            return Utility.GetSinglePrivateKey(mnemonic: mnemonic) ?? ""
        }
    }

    var pubKey : String {
        get{
            return Utility.GetSinglePublicKey(mnemonic: mnemonic) ?? ""
        }
    }

    var address : String {
        get{
            return Utility.GetAddress(publicKey: pubKey) ?? ""
        }
    }
    
    //sign
    let msg = "message"
    var sign : [UInt8] {
        get{
            return Utility.Sign(privateKey: privKey, buf: [UInt8](msg.utf8))
        }
    }
    
    //verify
    var verify :Bool {
        get{
            return Utility.Verify(publicKey:pubKey,buf:[UInt8](msg.utf8),signedBuf:sign)
        }
    }
    
    //Did
    var Did : String {
        get{
            return Utility.GetDid(publicKey: pubKey) ?? ""
        }
    }
    
    
    
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    print("Mnemonic : " + mnemonic)
    print("privKey : " + privKey)
    print("pubKey : " + pubKey)
    print("address : " + address)
    
    var strSign = "sign :"
    for item in sign {
        strSign += String(format:"%02x",item)
    }
    print(strSign)
    
    print("verify : " + String(verify))
    print("Did : " + Did)
    
    
// Do any additional setup after loading the view, typically from a nib.
    
//    var mnemonic = ElastosKeypair.GenerateMnemonic(language: "english", words: "")
//    mnemonic = "hobby theme load okay village inhale garlic box cement draft patrol net"
//
//    var seed = Data()
//    let seedLen = ElastosKeypair.GetSeedFromMnemonic(seed: &seed,
//                                                       mnemonic: mnemonic, language: "english", words: "",
//                                                       mnemonicPassword: "")
//
//    let seedStr = seed.hexEncodedString()
//
//
//    let privKey = ElastosKeypair.GetSinglePrivateKey(seed: seed, seedLen: seedLen)
//
//    let pubKey = ElastosKeypair.GetSinglePublicKey(seed: seed, seedLen: seedLen)
//
//    //let pubKeyVerify = ElastosKeypair.GetPublicKeyFromPrivateKey(privateKey: privKey)
//
//    let address = ElastosKeypair.GetAddress(publicKey: pubKey)
//
//
//    let txStr = "{\"Transactions\":[{\"Fee\":100,\"UTXOInputs\":[{\"index\":1,\"txid\":\"0bed4adf9be2a503d7f077db31a42b2d740db73d75fc3813166e6e5be304ca13\",\"privateKey\":\"1fc3ebc259dd12d444184da98e8447943926d026526fd8dd5d558a9353fd3bbc\",\"address\":\"EbAATdrW7gaomFY3SAy81rokqwqKA3EXbT\"}],\"Outputs\":[{\"amount\":10000,\"address\":\"EMHc9JSpxKWbTMf8gQDcWm7Tz1C5nQNA8Z\"},{\"amount\":48735988890,\"address\":\"EbAATdrW7gaomFY3SAy81rokqwqKA3EXbT\"}]}]}"
//
//    let signedData = ElastosKeypair.GenerateRawTransaction(transaction: txStr)
//
//
//
//    let a = 0

    
    }


}

extension Data {
  func hexEncodedString() -> String {
    return map { String(format: "%02hhX", $0) }.joined()
  }
}
