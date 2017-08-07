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

class LoginViewController: BaseViewController {

    var usernameTF: UITextField!
    var passwordTF: UITextField!
    var loginButton: UIButton!
    var backgroundView: UIImageView!
    var signInActivityIndicator: UIActivityIndicatorView!
    var usernameLabel: UILabel!
    var passwordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearNavigationBarColor()
        self.setUpUI()
        self.customizeTF()
    }

    func showAlert() {
        let alertView = UIAlertController(title: "Login", message: "Let us go!", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title: "Sure", style: UIAlertActionStyle.default) { _ in
            alertView.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        
        alertView.addAction(alertAction)
        
        self.present(alertView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func setUpUI() {
        
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "登 录"
        
        backgroundView = UIImageView().then {
            $0.image = UIImage.init(named: "background")
        }
        
        usernameTF = UITextField().then {
            $0.text = "dander521"
            $0.layer.borderColor = UIColor.red.cgColor
            $0.backgroundColor = UIColor.white
            $0.layer.borderWidth = 1
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.placeholder = "请输入账号"
            $0.borderStyle = UITextBorderStyle.none
            $0.textAlignment = NSTextAlignment.center
        }
        
        passwordTF = UITextField().then {
            $0.text = "ad123000"
            $0.isSecureTextEntry = true
            $0.placeholder = "请输入密码"
            $0.borderStyle = UITextBorderStyle.none
            $0.backgroundColor = UIColor.white
            $0.layer.borderColor = UIColor.red.cgColor
            $0.layer.borderWidth = 1
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = NSTextAlignment.center
        }
        
        loginButton = UIButton().then {
            $0.backgroundColor = UIColor.green
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            $0.setTitle("Login", for: UIControlState.normal)
            $0.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
        
        usernameLabel = UILabel().then {
            $0.textAlignment = NSTextAlignment.left
            $0.textColor = UIColor.red
            $0.text = "请输入6-10位用户名"
        }
        
        passwordLabel = UILabel().then {
            $0.textAlignment = NSTextAlignment.left
            $0.textColor = UIColor.red
            $0.text = "请输入6-10位密码"
        }
        
        signInActivityIndicator = UIActivityIndicatorView()
        signInActivityIndicator.hidesWhenStopped = true

        loginButton.addSubview(signInActivityIndicator)
        view.addSubview(backgroundView)
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        
        signInActivityIndicator.mas_makeConstraints { make in
            make?.left.equalTo()(self.loginButton)?.setOffset(40)
            make?.top.equalTo()(self.loginButton)?.setOffset(15)
            make?.height.equalTo()(20)
            make?.width.equalTo()(20)
        }
        
        backgroundView.mas_makeConstraints {make in
            make?.edges.mas_equalTo()(self.view)
        }
        
        usernameTF.mas_makeConstraints { make in
            make?.top.equalTo()(self.view)?.setOffset(100)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(44)
        }
        
        passwordTF.mas_makeConstraints { make in
            make?.top.equalTo()(self.usernameTF.mas_bottom)?.setOffset(60)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(44)
        }
        
        loginButton.mas_makeConstraints { make in
            make?.top.equalTo()(self.passwordTF.mas_bottom)?.setOffset(60)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(50)
        }
        
        usernameLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.usernameTF.mas_bottom)?.setOffset(20)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(20)
        }
        
        passwordLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.passwordTF.mas_bottom)?.setOffset(20)
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view)?.setOffset(-20)
            make?.height.equalTo()(20)
        }
    }
}

extension LoginViewController {
    func customizeTF() {
        usernameTF.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
    }
}
