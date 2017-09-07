//
//  LoginCodeModel.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit
import HandyJSON

class LoginCodeModel: HandyJSON {

    var msg: String?
    var code: Int?
    var success: Bool?
    var data: Dictionary<String, Any> = [:]
    
    required init() {}
}
 
