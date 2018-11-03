//
//  ViewController.swift
//  test
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

import UIKit

import ElastosWalletLib

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let mmemonic = ElastosWallet.GenerateMnemonic(language: "english", path: "")
    
    let privKey = ElastosWallet.GetMasterPrivateKey(mmemonic: mmemonic!, language: "english", path: "", password: "0")
  }


}

