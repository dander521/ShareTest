//
//  BMPViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/5/26.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit
import HandyJSON

class BMPViewController: BaseViewController, BMKMapViewDelegate, BMKLocationServiceDelegate, CustomBottomViewDelegate {
    
    var locationService: BMKLocationService!
    var mapView: BMKMapView!
    var projectArray: [ProjectModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置控制器
        self.configViewController()
        
        mapView = BMKMapView.init(frame: view.frame)
        view.addSubview(mapView)
        
        if let customBottomView = CustomBottomView.newInstance() {
            customBottomView.delegate = self
            view.addSubview(customBottomView)
        }
        
        locationService = BMKLocationService()
        locationService.allowsBackgroundLocationUpdates = true
        
        locationService.startUserLocationService()
        mapView.userTrackingMode = BMKUserTrackingModeFollow
        mapView.showsUserLocation = true
        mapView.zoomLevel = 20;
        
        getProject()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationService.delegate = self
        mapView.delegate = self
        mapView.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationService.delegate = self
        mapView.delegate = nil
        mapView.viewWillDisappear()
        
        locationService.stopUserLocationService()
        mapView.showsUserLocation = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getProject() {
        MBProgressHUD.showMessage("请求中...")
        UhomeNetManager.sharedInstance.postRequest(urlString: getCityProject, params: ["id" : TXUserModel.defaultUser().userId, "lon" : "104.064095", "lat" : "30.551882", "key" : "房", "price_from" : "0", "price_end" : "10000"], success: { (successJson) in
            MBProgressHUD.hide()
            /*
             {
             code = 0;
             data =     {
             status = 0;
             values = "";
             };
             msg = "\U83b7\U53d6\U5c0f\U533a\U4fe1\U606f";
             succcess = true;
             }
             */
            if let array = [ProjectModel].deserialize(from: successJson, designatedPath: "data.values") {
                self.projectArray = array as? [ProjectModel]
                print("array = \(array)")
            } else {
                print("解析失败")
            }
            
        }, failure: { (errorMsg) in
            MBProgressHUD.hide()
        })
    }
    
    //MARK: - Custom Method
    func configViewController() {
        view.backgroundColor = UIColor.white
        clearNavigationBarColor()
    }
    
    // MARK: - BMKMapViewDelegate
    
    
    // MARK: - BMKLocationServiceDelegate
    
    /**
     *在地图View将要启动定位时，会调用此函数
     *@param mapView 地图View
     */
    func willStartLocatingUser() {
        print("willStartLocatingUser");
    }
    
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        print("heading is \(userLocation.heading)")
        mapView.updateLocationData(userLocation)
    }
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
        
        TXModelAchivar.updateUserModel(withKey: "longitude", value: NSString(format: "%f" , userLocation.location.coordinate.longitude) as String! as String!)
        TXModelAchivar.updateUserModel(withKey: "latitude", value: NSString(format: "%f" , userLocation.location.coordinate.latitude) as String! as String!)
        
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        mapView.updateLocationData(userLocation)
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }
    
    func clearNavigationBarColor() {
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.black
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 16)
        self.navigationController?.navigationBar.titleTextAttributes = textAttrs
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - CustomBottomViewDelegate
    
    func responseToQuestionBtn() {
        print("responseToQuestionBtn")
    }
    
    func responseToLocationBtn() {
        print("responseToLocationBtn")
    }
    
    func responseToQrcodeBtn() {
        print("responseToQrcodeBtn")
        let vwcHouse = ProjectHousesViewController()
        vwcHouse.projectId = String.init(format: "%d", 2)
        self.navigationController?.pushViewController(vwcHouse, animated: true)
    }
    
    func responseToNextBtn() {
        print("responseToNextBtn")
    }
    
    func responseToPersonalBtn() {
        
        if TXUserModel().userLoginStatus() == false {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        } else {
            self.navigationController?.pushViewController(PersonalViewController(), animated: true)
        }
    }
    
    func responseToActiveBtn() {
        navigationController?.pushViewController(ActivityViewController(), animated: true)
    }
    
}
