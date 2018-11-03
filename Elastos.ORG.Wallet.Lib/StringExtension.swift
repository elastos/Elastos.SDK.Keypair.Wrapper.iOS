//
//  StringExtension.swift
//  lib
//
//  Created by mengxk on 2018/11/3.
//  Copyright © 2018 Elastos. All rights reserved.
//

extension String {
  static func ToUnsafeMutablePointer(data: String?) -> UnsafeMutablePointer<Int8>? {
    guard data != nil else { return nil }
    var dataCString = data!.utf8CString
    return dataCString.withUnsafeMutableBytes { d in
      return d.baseAddress!.bindMemory(to: Int8.self, capacity: d.count)
    }
  }
  static func FromUnsafeMutablePointer(data: UnsafeMutablePointer<Int8>?) -> String? {
    guard data != nil else { return nil }
    return String(cString: data!)
  }
}
