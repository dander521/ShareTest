//
//  ProjectHousesViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class ProjectHousesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView:UITableView?
    var dataArr = NSMutableArray()
    open var projectId: String?
    var houseArray: [HouseModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "青南美湾"
        self.view.backgroundColor = UIColor.white
        
        //初始化数据源
        for i in 0...99{
            dataArr.add("这是第\(i)行")
        }
        //定义表视图
        let rect:CGRect=self.view.bounds//取得self.view的大小
        tableView=UITableView(frame: rect,style: .plain)
        tableView!.dataSource=self
        tableView!.delegate=self
        self.view.addSubview(tableView!)
        
        print("projectId is \(String(describing: projectId))")
        
        getCustomHouses()
    }
    
    func getCustomHouses() {
        MBProgressHUD.showMessage("请求中...")
        let params = NSMutableDictionary()
        params.setValue(projectId, forKey: "project_id")
        UhomeNetManager.sharedInstance.postRequest(urlString: getHouses, params: params as! [String : Any], success: { (successJson) in
            MBProgressHUD.hide()

            if let array = [HouseModel].deserialize(from: successJson, designatedPath: "data") {
                self.houseArray = array as? [HouseModel]
                print("self.projectArray?.count = \(String(describing: self.houseArray?.count))")
            } else {
                print("解析失败")
            }
            
        }, failure: { (errorMsg) in
            MBProgressHUD.hide()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //实现dataSource协议 多行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = HouseTableViewCell.cellWithTableView(tableView: tableView)
        let s = dataArr.object(at: indexPath.row) as! String
        cell.textLabel?.text=s
        return cell
    }
    
    //实现Delegate协议 点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("\(indexPath)行被点击了")
        
        let vwcHouse = HouseDetailViewController()
        vwcHouse.houseId = String.init(format: "%d", indexPath.row)
        navigationController?.pushViewController(vwcHouse, animated: true)
        
    }
}
