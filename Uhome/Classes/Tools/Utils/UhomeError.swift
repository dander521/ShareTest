//
//  UhomeErrorType.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/6/14.
//  Copyright © 2017年 menhao. All rights reserved.
//

import Foundation

public protocol UhomeErrorType: Error {
    var message: String { get }
}

public struct UhomeError: UhomeErrorType {
    
    public let message: String
    
    public init(message m: String) {
        message = m
    }
    
}
