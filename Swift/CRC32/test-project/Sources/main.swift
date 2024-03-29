/*--------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/
import Foundation
final class CRC32 {
    static let MPEG2 = CRC32(polynomial: 0x04c11db7)
    

    let table: [UInt32]

    init(polynomial: UInt32) {
        var table: [UInt32] = [UInt32](repeating: 0x00000000, count: 256)
        for i in 0..<table.count {
            var crc = UInt32(i) << 24
            for _ in 0..<8 {
                crc = (crc << 1) ^ ((crc & 0x80000000) == 0x80000000 ? polynomial : 0)
            }
            table[i] = crc
        }
        self.table = table
    }

    func calculate(_ data: Data) -> UInt32 {
        return calculate(data, seed: nil)
    }

    func calculate(_ data: Data, seed: UInt32?) -> UInt32 {
        var crc: UInt32 = seed ?? 0xffffffff
        for i in 0..<data.count {
            crc = (crc << 8) ^ table[Int((crc >> 24) ^ (UInt32(data[i]) & 0xff) & 0xff)]
        }
        return crc
    }
}