//
//  StringExtension.swift
//  lib
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

import Foundation

extension String {
  static func ToUnsafeMutablePointer(data: String?) -> UnsafeMutablePointer<Int8>? {
    guard data != nil else { return nil }
    
    let dataBuf = data!.data(using: String.Encoding.utf8, allowLossyConversion: false)
    let unsafePointer = UnsafeMutablePointer<UInt8>.allocate(capacity: dataBuf!.count + 1)
    unsafePointer.initialize(repeating: 0, count: dataBuf!.count + 1)
    dataBuf!.copyBytes(to: unsafePointer, count: dataBuf!.count)
    
    let opaquePtr = OpaquePointer(unsafePointer)
    
    return UnsafeMutablePointer<Int8>(opaquePtr)
  }
  static func FromUnsafeMutablePointer(data: UnsafeMutablePointer<Int8>?) -> String? {
    guard data != nil else { return nil }
    return String(cString: data!)
  }
  
  static func FromUnsafeMutablePointer(data: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> [String]? {
    guard data != nil else { return nil }
    var ptr = data!
    var strArray: [String] = []
    while let s = ptr.pointee {
      strArray.append(String(cString: s))
      ptr += 1
    }
    return strArray
  }
}

extension Data {
  static func ToUnsafeMutablePointer(data: Data?) -> UnsafeMutableRawPointer? {
    guard data != nil else { return nil }
    
    let unsafePointer = UnsafeMutablePointer<UInt8>.allocate(capacity: data!.count)
    unsafePointer.initialize(repeating: 0, count: data!.count) // is this necessary?
    data!.copyBytes(to: unsafePointer, count: data!.count)
    
    let opaquePtr = OpaquePointer(unsafePointer)
    
    return UnsafeMutableRawPointer(opaquePtr)
  }
  static func FromUnsafeMutablePointer(data: UnsafeMutableRawPointer?, size: Int) -> Data? {
    guard data != nil else { return nil }
    return Data(bytes: data!, count: Int(size))
  }
}
