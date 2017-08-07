//
//  UhomeFunctionTools.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/6/12.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class UhomeFunctionTools: NSObject {

    class public func example(_ description: String, action: (Void) -> Void) {
        printExampleHeader(description)
        action()
    }
    
    class public func printExampleHeader(_ description: String) {
        print("\n--- \(description) example ---")
    }
    
    public enum TestError: Swift.Error {
        case test
    }

    class public func delay(_ delay: Double, closure: @escaping (Void) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}
