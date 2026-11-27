//
//  CInterop.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

#if canImport(System)
import System
#else
import SystemPackage
#endif
@_implementationOnly import CNetlink
#if canImport(Glibc)
import Glibc
#elseif canImport(Darwin)
import Darwin
#endif

public extension CInterop {
    
    
}
