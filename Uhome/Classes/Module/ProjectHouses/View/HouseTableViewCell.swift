//
//  HouseTableViewCell.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/9/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit
import SDWebImage

class HouseTableViewCell: UITableViewCell {

    @IBOutlet weak var houseImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var customerImpressionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    open var model:HouseModel? {
        didSet {
            self.houseImageView.sd_setImage(with: URL(string: hostAddress + (model?.img_url)!), placeholderImage: UIImage.init(named: "ic_tab_home_default"), options: .retryFailed, completed: { (image, error, cacheType, imageURL) in
                
            })
            self.nameLabel.text = model?.title
            self.conditionLabel.text = model?.mianji
            self.customerImpressionLabel.text = model?.huxing
            self.priceLabel.text = model?.rent
        }
    }
    
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
