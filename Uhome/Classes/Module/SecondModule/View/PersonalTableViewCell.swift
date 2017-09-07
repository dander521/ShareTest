//
//  PersonalTableViewCell.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

class PersonalTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellWithTableView(tableView: UITableView) -> PersonalTableViewCell {
        let cellId = "PersonalTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = Bundle.main.loadNibNamed("PersonalTableViewCell", owner: self, options: nil)?.first as! PersonalTableViewCell
        }
        return cell as! PersonalTableViewCell
    }
}
