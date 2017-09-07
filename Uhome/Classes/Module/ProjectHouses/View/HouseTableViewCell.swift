//
//  HouseTableViewCell.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellWithTableView(tableView: UITableView) -> HouseTableViewCell {
        let cellId = "HouseTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = Bundle.main.loadNibNamed("HouseTableViewCell", owner: self, options: nil)?.first as! HouseTableViewCell
        }
        return cell as! HouseTableViewCell
    }
    
}
