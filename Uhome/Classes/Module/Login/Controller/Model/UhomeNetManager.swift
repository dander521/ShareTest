//
//  UhomeNetManager.swift
//  Uhome
//
//  Created by 倩倩 on 2017/8/10.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD

private let UhomeNetManagerShareInstance = UhomeNetManager()

class UhomeNetManager: NSObject {
    
    class var sharedInstance : UhomeNetManager {
        return UhomeNetManagerShareInstance
    }
}

extension UhomeNetManager {
    func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : String)->(), failure : @escaping (_ error : String)->()) {
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseString { (string) in/*这里使用了闭包*/
            let startRange = string.description.range(of:"{") //正向检索
            let endRange = string.description.range(of:"}", options: .backwards)//反向检索
            let searchRange = (startRange?.lowerBound)! ..< (endRange?.upperBound)!
            let resultString = string.description.substring(with: searchRange)
            
            let dic = UhomeFunctionTools.getDictionaryFromJSONString(jsonString: resultString)
            
            print("Get Json >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n \(dic)")
            if dic.count > 0 {
                let succcess = dic["succcess"] as! String
                let errorMsg = dic["msg"] as! String
                
                if succcess == "true" {
                    success(resultString)
                } else {
                    failure(errorMsg)
                }
            } else {
                print(">>>>>>>>>>>>>服务器数据异常>>>>>>>>>>>>>>>>")
            }
        }
    }
    //MARK: - POST 请求
    func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : String)->(), failure : @escaping (_ error : String)->()) {
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseString { (string) in
            
            let startRange = string.description.range(of:"{") //正向检索
            let endRange = string.description.range(of:"}", options: .backwards)//反向检索
            let searchRange = (startRange?.lowerBound)! ..< (endRange?.upperBound)!
            let resultString = string.description.substring(with: searchRange)
            
            let dic = UhomeFunctionTools.getDictionaryFromJSONString(jsonString: resultString)
            
            print("Post Json >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n \(dic)")
            if dic.count == 0 {
                print(">>>>>>>>>>>>服务器数据错误>>>>>>>>>>>>>>>>>")
            } else {
                let succcess = dic["succcess"] as! String
                let errorMsg = dic["msg"] as! String
                
                if succcess == "true" {
                    success(resultString)
                } else {
                    failure(errorMsg)
                }
            }
        }
    }
    
    //MARK: - 照片上传
    ///
    /// - Parameters:
    ///   - urlString: 服务器地址
    ///   - params: ["flag":"","userId":""] - flag,userId 为必传参数
    ///        flag - 666 信息上传多张  －999 服务单上传  －000 头像上传
    ///   - data: image转换成Data
    ///   - name: fileName
    ///   - success:
    ///   - failture:
    func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        if let value = response.result.value as? [String: AnyObject]{
//                            success(value)
//                            let json = JSON(value)
//                            PrintLog(json)
//                        }
//                    }
//                case .failure(let encodingError):
//                    PrintLog(encodingError)
//                    failture(encodingError)
//                }
            }
        )
    }
}
