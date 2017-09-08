//
//  HouseDetailViewController.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    open var houseId: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "青南美湾2-1-1506"
        self.view.backgroundColor = UIColor.white
        
        let calendar = FSCalendar.init(frame: CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 340))
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.appearance.selectionColor = UIColor.blue
        calendar.appearance.todaySelectionColor = UIColor.blue
        calendar.placeholderType = FSCalendarPlaceholderType.fillHeadTail
        
        calendar.backgroundColor = UIColor.white;
        view.addSubview(calendar)
        
        print("houseId is \(String(describing: houseId))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return "刚";
    }
    
    
    
    //MARK: - FSCalendarDataSource
    func minimumDate(for calendar: FSCalendar) -> Date {
        let date = NSDate()
        return date as Date
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let date = NSDate(timeIntervalSinceNow: 90*24*60*60)
        return date as Date
    }
}
