//
//  Utility.swift
//  lib
//
//  Created by xu xinlai on 2019/3/1.
//  Copyright © 2019年 Elastos. All rights reserved.
//

import Foundation

open class Utility{
    
    private static let Ela_Language = ["zh":"chinese","es":"spanish","en":"english","fr":"french","ja":"japanese"]
    public static func GenerateMnemonic(language: String = "en")->String{
        
        let lang = detectLang(Lang: language)
        return ElastosKeypair.GenerateMnemonic(language: Ela_Language[lang]!, words: getWords(Language: lang)) ?? ""
        
    }
    
    public static func GenerateMnemonic(language: String,words: String?)->String{
        return ElastosKeypair.GenerateMnemonic(language: language, words: words) ?? ""
    }
    
    public static func GetSinglePrivateKey(mnemonic: String) -> String? {
        let seeds = GetSeedFromMnemonic(mnemonic: mnemonic)
        let privKey = ElastosKeypair.GetSinglePrivateKey(seed: seeds.1, seedLen: seeds.0)
        return privKey
    }
    
    private static func GetSeedFromMnemonic(mnemonic: String)->(Int,Data){
        let lang = detectLang(Lang: checkLangWith(string: mnemonic)!)
        return GetSeedFromMnemonic(mnemonic: mnemonic, language: Ela_Language[lang] ?? "", words: getWords(Language: lang), mnemonicPassword: "")
    }
    
    private static func GetSeedFromMnemonic(mnemonic: String, language: String, words: String?,
                                            mnemonicPassword: String?)->(Int,Data){
        
        var seed = Data()
        let seedLen = ElastosKeypair.GetSeedFromMnemonic(seed: &seed,
                                                         mnemonic: mnemonic, language: language, words: words ?? "",
                                                         mnemonicPassword: mnemonicPassword ?? "")
        return (seedLen,seed)
    }
    
    private static func GetSinglePublicKey(seed: Data?, seedLen: Int) -> String? {
        let pubKey = ElastosKeypair.GetSinglePublicKey(seed: seed, seedLen: seedLen)
        return pubKey
    }
    
    public static func GetSinglePublicKey(mnemonic: String) -> String? {
        let seeds = GetSeedFromMnemonic(mnemonic: mnemonic)
        let pubKey = ElastosKeypair.GetSinglePublicKey(seed: seeds.1, seedLen: seeds.0)
        return pubKey
    }
    
    public static func GetAddress(publicKey: String?) -> String? {
        let address = ElastosKeypair.GetAddress(publicKey: publicKey)
        return address
    }
    
    //sign from byte to byte
    public static func Sign(privateKey: String?, buf: [UInt8]) -> [UInt8] {
        
        var sigData =  Data()
        var data = buffterToData(buffer:buf)
        
        let _ = ElastosKeypair.Sign(privateKey: privateKey,
                                    data: data,
                                    len: data.count,
                                    signedData: &sigData)
        
        let sigBytes = [UInt8](sigData)
        return sigBytes
    }
    
    
    
    
    //from data to data
    public static func Sign(privateKey: String?, data: Data) -> Data {
        var sigData = Data()
        let _ = ElastosKeypair.Sign(privateKey: privateKey,
                                    data: data,
                                    len: data.count,
                                    signedData: &sigData)
        
        return sigData
    }

    //verifty byte to byte
    public static func Verify(publicKey: String?, buf: [UInt8],signedBuf:[UInt8]) -> Bool {
        
        let data = buffterToData(buffer:buf)
        let signedData = buffterToData(buffer:signedBuf)
        
        let verifyResult = AbstractLayer.Verify(publicKey: publicKey,
                                                data: data,
                                                len: data.count,
                                                signedData: signedData,
                                                signedLen: signedData.count)
        
        return verifyResult
    }
    
    //verifty data to data
    public static func Verify(publicKey: String?, data: Data, len: Int, signedData:Data,signedLen:Int) -> Bool {
        
        
        let verifyResult = AbstractLayer.Verify(publicKey: publicKey,
                                                data: data,
                                                len: len,
                                                signedData: signedData,
                                                signedLen: signedLen)
        
        return verifyResult
    }
    

    
    public static func GetDid(publicKey: String?) -> String? {
        let address = ElastosKeypair.GetDid(publicKey: publicKey)
        return address
    }
    
    private static func detectLang(Lang:String)->String{
        
        switch String(describing: Lang) {
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans","zh":
            return "zh"
        case "es":
            return "es"
        case "fr":
            return "fr"
        case "ja":
            return "ja"
        default:
            return "en"
        }
    }
    
    private static func getWords(Language: String = "en")->String{
        
        let path = Bundle.main.path(forResource: detectLang(Lang: Language) + "-BIP39Words",ofType: "txt")
        let mWords = try!String.init(contentsOf: URL.init(fileURLWithPath: path!), encoding: String.Encoding.utf8)
        return mWords
        
    }

}

extension Utility {
    
    private static func checkLangWith(string:String)->String?{
        let tagSchemes = [NSLinguisticTagScheme.language]
        let tagger = NSLinguisticTagger(tagSchemes: tagSchemes, options: 0)
        tagger.string = string
        let lang = tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language, tokenRange: nil, sentenceRange: nil)
        return lang.map { $0.rawValue }
    }
    
    private static func buffterToData(buffer:[UInt8])->Data{
        
        let nsdata = NSData(bytes: buffer as [UInt8], length: buffer.count)
        return Data(referencing: nsdata)
        
    }


}
