//
//  BMPViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/5/26.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class BMPViewController: BaseViewController, BMKMapViewDelegate, BMKLocationServiceDelegate, CustomBottomViewDelegate {
    
    var locationService: BMKLocationService!
    var mapView: BMKMapView!

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
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeFollow
        mapView.showsUserLocation = true
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
        textAttrs[NSForegroundColorAttributeName] = UIColor.white
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
        
    }
    
    func responseToQrcodeBtn() {
        
    }
    
    func responseToPersonalBtn() {
        
    }
    
    func responseToActiveBtn() {
        
    }
}
