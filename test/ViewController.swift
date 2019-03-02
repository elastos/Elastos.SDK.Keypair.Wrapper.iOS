//
//  ViewController.swift
//  test
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

import UIKit

import ElastosSdkKeypair

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let listArray = ["get Mnemonic","get single priv","get publickey","get address","Sign","verrify","getDid"]
  
    var strSign = ""
    @IBOutlet weak var tabview: UITableView!
    
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
    
    //for print
    print("Mnemonic : " + mnemonic)
    print("privKey : " + privKey)
    print("pubKey : " + pubKey)
    print("address : " + address)

    strSign = ""
    for item in sign {
        strSign += String(format:"%02x",item)
    }
    print(strSign)
    print("verify : " + String(verify))
    print("Did : " + Did)
    
    //for show list
    tabview.delegate = self
    tabview.dataSource = self
    
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellid")
        cell.textLabel?.text = listArray[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var str = ""
        switch indexPath.row {
        case 0:
            str = mnemonic
        case 1:
            str = privKey
        case 2:
            str = pubKey
        case 3:
            str = address
        case 4:
            str = strSign
        case 5:
            str = String(verify)
        case 6:
            str = Did
        default:
            str = ""
        }
        
        
        let alertController = UIAlertController(title: "",
                                                message: str, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

}

extension Data {
  func hexEncodedString() -> String {
    return map { String(format: "%02hhX", $0) }.joined()
  }
}
