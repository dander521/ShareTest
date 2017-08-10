//
//  LoginViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/6/2.
//  Copyright © 2017年 menhao. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD
import Then
import Alamofire
import HandyJSON

class LoginViewController: BaseViewController {
    
    var backgroundView: UIImageView!
    var headImageView: UIImageView!
    var headLabel: UILabel!
    var phoneTF: UITextField!
    var codeViewTF: UITextField!
    var codeView: WSAuthCode!
    var pincodeTF: UITextField!
    var pincodeButton: UIButton!
    var loginButton: UIButton!
    
    var phoneLabel: UILabel!
    var codeViewLabel: UILabel!
    var pincodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearNavigationBarColor()
        self.setUpUI()
        self.customizeTF()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// 导航栏透明
    func clearNavigationBarColor() {
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.white
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 16)
        self.navigationController?.navigationBar.titleTextAttributes = textAttrs
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        navigationController?.navigationBar.isTranslucent = true
    }
    
    /// 登录
    func touchLoginBtn() {
//        UIApplication.shared.keyWindow?.rootViewController = MainNavigationController.init(rootViewController: BMPViewController())
//        TXModelAchivar.updateUserModel(withKey: "isLogin", value: "0")
        requestLogin()
    }
    
    func requestLogin() {
        
        KRProgressHUD.show()
        UhomeNetManager.sharedInstance.postRequest(urlString: "http://www.damudichan.com/api/app/get.asmx/get_prices", params: ["house_id" : "1"], success: { (successJson) in
            KRProgressHUD.showSuccess()
            if let model = JSONDeserializer<LoginModel>.deserializeFrom(json: successJson) {
                print(model.msg ?? "msg")
            }
        }, failure: { (errorMsg) in
            KRProgressHUD.showMessage(errorMsg)
        })
    }
    
    
    /// 获取手机验证码
    func touchPincodeBtn() {
        TXCountDownTime.shared().start(withTime: 60, title: "获取验证码", countDownTitle: "重新获取", mainColor: UIColor.yellow, count: UIColor.lightGray, atBtn: self.pincodeButton)
    }
    
    /// 刷新图形验证码
    func touchRefreshPincodeBtn() {
        codeView.reloadView()
    }
    
    /// 配置UI
    func setUpUI() {
        
        view.backgroundColor = UIColor.white

        backgroundView = UIImageView().then {
            $0.backgroundColor = UIColor.clear
        }
        
        codeView = WSAuthCode.init(frame: CGRect(x:0,y:0,width:100,height:44), allWordArraytype: OnlyNumbers)
        
        headImageView = UIImageView().then {
            $0.backgroundColor = UIColor.clear
            $0.image = UIImage.init(named: "background")
            $0.layer.cornerRadius = 50
            $0.layer.masksToBounds = true
        }
        
        headLabel = UILabel().then {
            $0.backgroundColor = UIColor.clear
            $0.text = "TKC光轴链"
            $0.textAlignment = NSTextAlignment.center
            $0.textColor = UIColor.black
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        
        phoneLabel = UILabel().then {
            $0.backgroundColor = UIColor.black
        }
        
        codeViewLabel = UILabel().then {
            $0.backgroundColor = UIColor.black
        }
        
        pincodeLabel = UILabel().then {
            $0.backgroundColor = UIColor.black
        }
        
        phoneTF = UITextField().then {
            $0.backgroundColor = UIColor.white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.borderStyle = UITextBorderStyle.none
            $0.textAlignment = NSTextAlignment.left
        }
        
        pincodeTF = UITextField().then {
            $0.isSecureTextEntry = false
            $0.borderStyle = UITextBorderStyle.none
            $0.backgroundColor = UIColor.white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = NSTextAlignment.left
        }
        
        codeViewTF = UITextField().then {
            $0.isSecureTextEntry = false
            $0.borderStyle = UITextBorderStyle.none
            $0.backgroundColor = UIColor.white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = NSTextAlignment.left
        }
        
        pincodeButton = UIButton().then {
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor.yellow
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            $0.setTitle("获取验证码", for: UIControlState.normal)
            $0.setTitleColor(UIColor.black, for: UIControlState.normal)
            $0.addTarget(self, action: #selector(LoginViewController.touchPincodeBtn), for: UIControlEvents.touchUpInside)
        }
        
        loginButton = UIButton().then {
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor.yellow
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            $0.setTitle("登 录", for: UIControlState.normal)
            $0.setTitleColor(UIColor.black, for: UIControlState.normal)
            $0.addTarget(self, action: #selector(LoginViewController.touchLoginBtn), for: UIControlEvents.touchUpInside)
        }

        view.addSubview(backgroundView)
        view.addSubview(headImageView)
        view.addSubview(headLabel)
        view.addSubview(phoneTF)
        view.addSubview(pincodeTF)
        view.addSubview(codeViewTF)
        view.addSubview(pincodeButton)
        view.addSubview(loginButton)
        view.addSubview(codeView)
        view.addSubview(phoneLabel)
        view.addSubview(codeViewLabel)
        view.addSubview(pincodeLabel)
        
        backgroundView.mas_makeConstraints {make in
            make?.edges.mas_equalTo()(self.view)
        }
        
        headImageView.mas_makeConstraints { make in
            make?.top.equalTo()(self.view)?.setOffset(100)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(100)
            make?.width.equalTo()(100)
        }
        
        headLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.headImageView.mas_bottom)?.setOffset(15)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(20)
            make?.width.equalTo()(150)
        }
        
        phoneTF.mas_makeConstraints { make in
            make?.top.equalTo()(self.headLabel.mas_bottom)?.setOffset(40)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(44)
        }
        
        codeViewTF.mas_makeConstraints { make in
            make?.top.equalTo()(self.phoneTF.mas_bottom)?.setOffset(20)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.codeView.mas_left)?.setOffset(-10)
            make?.height.equalTo()(44)
        }
        
        codeView.mas_makeConstraints { make in
            make?.top.equalTo()(self.phoneTF.mas_bottom)?.setOffset(20)
            make?.left.equalTo()(self.codeViewTF.mas_right)?.setOffset(10)
            make?.height.equalTo()(44)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.width.equalTo()(100)
        }
        
        pincodeTF.mas_makeConstraints { make in
            make?.top.equalTo()(self.codeView.mas_bottom)?.setOffset(20)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.height.equalTo()(44)
        }
        
        pincodeButton.mas_makeConstraints { make in
            make?.top.equalTo()(self.codeView.mas_bottom)?.setOffset(20)
            make?.left.equalTo()(self.pincodeTF.mas_right)?.setOffset(10)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(44)
            make?.width.equalTo()(100)
        }
        
        loginButton.mas_makeConstraints { make in
            make?.top.equalTo()(self.pincodeTF.mas_bottom)?.setOffset(60)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(50)
        }
        
        phoneLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.phoneTF.mas_bottom)
            make?.left.equalTo()(self.phoneTF.mas_left)
            make?.right.equalTo()(self.phoneTF.mas_right)
            make?.height.equalTo()(0.5)
        }
        
        codeViewLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.codeViewTF.mas_bottom)
            make?.left.equalTo()(self.codeViewTF.mas_left)
            make?.right.equalTo()(self.codeViewTF.mas_right)
            make?.height.equalTo()(0.5)
        }
        
        pincodeLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.pincodeTF.mas_bottom)
            make?.left.equalTo()(self.pincodeTF.mas_left)
            make?.right.equalTo()(self.pincodeTF.mas_right)
            make?.height.equalTo()(0.5)
        }
    }
}

extension LoginViewController {
    func customizeTF() {
        phoneTF.attributedPlaceholder = NSAttributedString(string: "输入手机号", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        codeViewTF.attributedPlaceholder = NSAttributedString(string: "图形验证码", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        pincodeTF.attributedPlaceholder = NSAttributedString(string: "输入验证码", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
    }
}
