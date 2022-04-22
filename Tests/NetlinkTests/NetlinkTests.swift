//
//  NetlinkTests.swift
//  PureSwift
//
//  Created by Alsey Coleman Miller on 7/6/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation
import XCTest
import CNetlink
@testable import Netlink

final class NetlinkTests: XCTestCase {
    
    func testErrorMessage() {
        
        do {
            
            /**
             Interface: wlx74da3826382c
             Wireless Extension Version: 0
             Wireless Extension Name: IEEE 802.11
             interface 3
             nl80211 NetlinkGenericFamilyIdentifier(rawValue: 28)
             Sent 28 bytes to kernel
             [28, 0, 0, 0, 28, 0, 1, 5, 0, 0, 0, 0, 52, 105, 0, 0, 32, 0, 0, 0, 8, 0, 3, 0, 3, 0, 0, 0]
             Recieved 48 bytes from the kernel
             [48, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 52, 105, 0, 0, 161, 255, 255, 255, 28, 0, 0, 0, 28, 0, 1, 5, 0, 0, 0, 0, 52, 105, 0, 0, 32, 0, 0, 0, 8, 0, 3, 0, 3, 0, 0, 0]
             */
            
            let data = Data([48, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 52, 105, 0, 0, 161, 255, 255, 255,
                             28, 0, 0, 0, 28, 0, 1, 5, 0, 0, 0, 0, 52, 105, 0, 0, 32, 0, 0, 0, 8, 0, 3, 0, 3, 0, 0, 0])
            
            guard let error = NetlinkErrorMessage(data: data)
                else { XCTFail("Could not parse message"); return }
            
            //XCTAssertEqual(error.data, data)
            XCTAssertEqual(error.length, 48)
            XCTAssertEqual(Int(error.length), data.count)
            XCTAssertEqual(error.sequence, 0)
            XCTAssertEqual(error.flags, [])
            XCTAssertEqual(error.type, .error)
            XCTAssertEqual(error.errorCode, -95)
            
            #if os(Linux)
            XCTAssertEqual(error.error?.code, .EOPNOTSUPP)
            #endif
        }
        
        do {
            
            /**
             Interface: wlx74da3826382c
             Wireless Extension Version: 0
             Wireless Extension Name: IEEE 802.11
             Interface: 6
             Trigger scan:
             [160, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 1, 0, 0, 8, 0, 1, 0, 3, 0, 0, 0, 8, 0, 3, 0, 6, 0, 0, 0, 12, 0, 153, 0, 1, 0, 0, 0, 3, 0, 0, 0, 4, 0, 45, 0, 108, 0, 44, 0, 8, 0, 0, 0, 108, 9, 0, 0, 8, 0, 1, 0, 113, 9, 0, 0, 8, 0, 2, 0, 118, 9, 0, 0, 8, 0, 3, 0, 123, 9, 0, 0, 8, 0, 4, 0, 128, 9, 0, 0, 8, 0, 5, 0, 133, 9, 0, 0, 8, 0, 6, 0, 138, 9, 0, 0, 8, 0, 7, 0, 143, 9, 0, 0, 8, 0, 8, 0, 148, 9, 0, 0, 8, 0, 9, 0, 153, 9, 0, 0, 8, 0, 10, 0, 158, 9, 0, 0, 8, 0, 11, 0, 163, 9, 0, 0, 8, 0, 12, 0, 168, 9, 0, 0]
             Scan results:
             [36, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 76, 68, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 28, 0, 5, 0, 0, 0, 0, 0, 76, 68, 0, 0]
             Networks:
             */
            
            let data = Data([36, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 76, 68, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 28, 0, 5, 0, 0, 0, 0, 0, 76, 68, 0, 0])
            
            guard let error = NetlinkErrorMessage(data: data)
                else { XCTFail("Could not parse message"); return }
            
            XCTAssertEqual(error.length, 36)
            XCTAssertEqual(Int(error.length), data.count)
            XCTAssertEqual(error.sequence, 0)
            XCTAssertEqual(error.type, .error)
            XCTAssertEqual(error.errorCode, 0)
        }
    }
}
