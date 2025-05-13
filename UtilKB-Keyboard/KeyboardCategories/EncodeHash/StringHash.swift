//
//  StringHash.swift
//  UtilKB
//
//  Created by An So on 2025-05-13.
//

import CryptoKit
import zlib
import Foundation

extension String {
  func sha256() -> String {
    let data = Data(self.utf8)
    let hash = SHA256.hash(data: data)
    return hash.compactMap { String(format: "%02x", $0) }.joined()
  }

  func sha1() -> String {
    let data = Data(self.utf8)
    let hash = Insecure.SHA1.hash(data: data)
    return hash.compactMap { String(format: "%02x", $0) }.joined()
  }

  func md5() -> String {
    let data = Data(self.utf8)
    let hash = Insecure.MD5.hash(data: data)
    return hash.compactMap { String(format: "%02x", $0) }.joined()
  }

  func crc32() -> String {
    let data = Data(self.utf8)
    let checksum = data.withUnsafeBytes { buffer -> UInt32 in
      var checksum: uLong = 0
      if let baseAddress = buffer.baseAddress {
        checksum = zlib.crc32(
          0, baseAddress.assumingMemoryBound(to: Bytef.self), uInt(buffer.count))
      }
      return UInt32(checksum)
    }
    return String(format: "%08x", checksum)
  }
}
