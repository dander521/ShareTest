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
    
    /// JSONString转换为字典
    ///
    /// - Parameter jsonString:
    /// - Returns:
    class public func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    /// 字典转换为JSONString
    ///
    /// - Parameter dictionary:
    /// - Returns:
    class public func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
}
