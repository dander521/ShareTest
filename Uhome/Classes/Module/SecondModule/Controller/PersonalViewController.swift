//
//  PersonalViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/8/8.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "个人中心"
        self.view.backgroundColor = UIColor.white

        //定义表视图
        let rect:CGRect=self.view.bounds//取得self.view的大小
        tableView=UITableView(frame: rect,style: .plain)
        tableView!.dataSource=self
        tableView!.delegate=self
        tableView!.tableHeaderView = customTableHeaderView()
        self.view.addSubview(tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customTableHeaderView() -> UIView {
        let phoneLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        phoneLabel.backgroundColor = UIColor.white
        phoneLabel.textAlignment = NSTextAlignment.left
        phoneLabel.font = UIFont.systemFont(ofSize: 20)
        phoneLabel.textColor = UIColor.black
        phoneLabel.text = TXUserModel.defaultUser().mobile
        return phoneLabel
    }
    
    //实现dataSource协议 多行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = PersonalTableViewCell.cellWithTableView(tableView: tableView)

        if indexPath.row == 0 {
            cell.textLabel?.text = "我的订单";
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "我的消息";
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "我的房子";
        } else {
            cell.textLabel?.text = "常见问题";
        }
        
        return cell
    }
    
    //实现Delegate协议 点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("\(indexPath)行被点击了")
        
        var vwcPush = UIViewController()
        if indexPath.row == 0 {
            vwcPush = MyOrderViewController()
        } else if indexPath.row == 1 {
            vwcPush = MyMessageViewController()
        } else if indexPath.row == 2 {
            vwcPush = MyHouseViewController()
        } else {
            vwcPush = CommonQuestionViewController()
        }
        
        navigationController?.pushViewController(vwcPush, animated: true)
        
    }
}
