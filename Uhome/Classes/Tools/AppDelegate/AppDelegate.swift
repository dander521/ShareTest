//
//  AppDelegate.swift
//  Uhome
//
//  Created by menhao on 17/5/24.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BMKGeneralDelegate {
    
    //MARK: - Variables
    var window: UIWindow?
    var _mapManager: BMKMapManager?

    //MARK: - System Method
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        // 配置根视图
        self.configRootViewController()
        self.window?.makeKeyAndVisible()
        
        // 添加百度地图
        self.configBMKSetting()
        // 添加键盘输入屏幕适配
        self.configKeyboardInputType()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    //MARK: - IQKeyboardManagerSwift
    func configKeyboardInputType() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldToolbarUsesTextFieldTintColor = false
    }
    
    //MARK: - Config RootViewController
    func configRootViewController() {
        let mainNavigation = MainNavigationController.init(rootViewController: BMPViewController())
        let loginViewController = MainNavigationController.init(rootViewController: LoginViewController())
        let leadingVC = TailorxLeadingViewController()
        
        let resultVC = TXUserModel().userLoginStatus() ? mainNavigation : loginViewController;
        
        // 获取版本号
        let currenVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let lastVersion = UserDefaults.standard.object(forKey: "CFBundleShortVersionString")
        if lastVersion != nil && currenVersion == lastVersion as! String {
            self.window?.rootViewController = resultVC
        } else {
            self.window?.rootViewController = leadingVC
            leadingVC.rootViewController = resultVC
            let userDefault = UserDefaults.standard
            userDefault.set(currenVersion, forKey: "CFBundleShortVersionString")
            userDefault.synchronize()
        }
    }
    
    //MARK: - BMKConfig
    func configBMKSetting() {
        // 要使用百度地图，请先启动BaiduMapManager
        _mapManager = BMKMapManager()
        /**
         *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
         *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
         *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
         */
        if BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORDTYPE_BD09LL) {
            NSLog("经纬度类型设置成功");
        } else {
            NSLog("经纬度类型设置失败");
        }
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("2hwNfoMfDLWZlz4QebGFehaw", generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        }
    }

    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }
        else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }
}

