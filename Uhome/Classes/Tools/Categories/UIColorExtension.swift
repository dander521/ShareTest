//
//  UIColorExtension.swift
//  Uhome
//
//  Created by menhao on 17/5/24.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit


extension UIColor{
    
    open class var randomColor:UIColor{
        
        let r  = CGFloat(arc4random()%255)/255
        
        let g = CGFloat(arc4random()%255)/255
        
        let b = CGFloat(arc4random()%255)/255
        
        let a = 255/255.0
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
}
