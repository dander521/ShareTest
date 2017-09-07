//
//  HouseDetailViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    open var houseId: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "青南美湾2-1-1506"
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
