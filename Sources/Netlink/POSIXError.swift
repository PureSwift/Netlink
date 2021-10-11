//
//  POSIXError.swift
//  
//
//  Created by Alsey Coleman Miller on 7/22/15.
//

import Foundation

#if canImport(Darwin)
internal extension POSIXError {
    
    /// Creates `POSIXError` from error code.
    init(code: POSIXErrorCode) {
        
        let nsError = NSError(
            domain: NSPOSIXErrorDomain,
            code: Int(code.rawValue),
            userInfo: [:]
        )
        
        self.init(_nsError: nsError)
    }
}
#endif
