//
//  BaseTypeConvertClass.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/8.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class BaseTypeConvertClass: NSObject {
    
    //简化版 CGFloat(Float(str))
    open class func StringToFloat(str:String)->(CGFloat){
        
        let string = str
        var cgFloat: CGFloat = 0
        
        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    //简化版 Int(str)
    open class func StringToInt(str:String)->(Int){
        
        let string = str
        var cgInt: Int = 0
        
        if let doubleValue = Double(string)
        {
            cgInt = Int(doubleValue)
        }
        return cgInt
    }
    //简化版Double(str)
    open class func StringToDouble(str:String)->(Double){
        
        let string = str
        var cgInt: Double = 0.0
        
        if let doubleValue = Double(string)
        {
            cgInt = (doubleValue)
        }
        return cgInt
    }
    
    open class func StringToData(str:String)->(Data){
        
        let strData = str.data(using: String.Encoding.utf8)
        
        return strData!
    }
    
    open class func DataToString(data:Data)->(String){
        
        let strData:String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        
        return strData
    }
    
}
