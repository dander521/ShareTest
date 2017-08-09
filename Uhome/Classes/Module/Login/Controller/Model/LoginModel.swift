//
//  LoginModel.swift
//  Uhome
//
//  Created by 倩倩 on 2017/8/9.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit
import HandyJSON

class LoginModel: HandyJSON {
    
    var msg: String?
    var code: Int?
    var success: Bool?
    var data: Dictionary<String, Any> = [:]
    
    required init() {}
}
