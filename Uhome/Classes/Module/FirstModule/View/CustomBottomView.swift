//
//  CustomBottomView.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/8/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

protocol CustomBottomViewDelegate {
    func responseToQuestionBtn()
    func responseToLocationBtn()
    func responseToQrcodeBtn(model: ProjectModel)
    func responseToPersonalBtn()
    func responseToActiveBtn()
    func responseToNextBtn(model: ProjectModel)
}

class CustomBottomView: UIView {
    
    var isShow: Bool = false
    
    open var delegate: CustomBottomViewDelegate?
    @IBOutlet weak var questionBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var showOrHideBtn: UIButton!
    @IBOutlet weak var qrcodeBtn: UIButton!
    @IBOutlet weak var personalBtn: UIButton!
    @IBOutlet weak var activeBtn: UIButton!
    @IBOutlet weak var nextHouseBtn: UIButton!
    var projectCount: Int = 0
    var selectedCount: Int = 0
    var currentModel: ProjectModel?
    
    open var projectModelArray:Array<ProjectModel>? {
        didSet {
            projectCount = (projectModelArray?.count)!

            if projectCount == 0 {
                self.qrcodeBtn.setTitle("暂无", for: UIControlState.normal)
                self.nextHouseBtn.isHidden = true
            } else {
                let model = projectModelArray?[0]
                self.currentModel = model
                self.qrcodeBtn.setTitle(model?.title, for: UIControlState.normal)
                if projectCount == 1 {
                    self.nextHouseBtn.isHidden = true
                } else {
                    self.nextHouseBtn.isHidden = false
                }
            }
        }
    }
    
    class func newInstance() -> CustomBottomView? {
        let nibView = Bundle.main.loadNibNamed("CustomBottomView", owner: nil, options: nil);
        if let view = nibView?.first as? CustomBottomView {
            return view
        }
        return nil
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 140, width: UIScreen.main.bounds.size.width, height: 310)
    }

    
    @IBAction func touchQuestionBtn(_ sender: UIButton) {
        self.delegate?.responseToQuestionBtn()
    }
    
    @IBAction func touchLocationBtn(_ sender: Any) {
        self.delegate?.responseToLocationBtn()
    }
    
    @IBAction func touchShowOrHideBtn(_ sender: UIButton) {
        var viewOriginY:CGFloat = 0.0
        if isShow {
            viewOriginY = UIScreen.main.bounds.size.height - 140
            isShow = false
        } else {
            viewOriginY = UIScreen.main.bounds.size.height - 310
            isShow = true
        }
        
        UIView.animate(withDuration: 0.25) { 
            self.frame.origin.y = CGFloat(viewOriginY)
        }
    }
    
    @IBAction func touchQrcodeBtn(_ sender: UIButton) {
        self.delegate?.responseToQrcodeBtn(model: currentModel!)
    }
    
    @IBAction func touchPersonalBtn(_ sender: UIButton) {
        self.delegate?.responseToPersonalBtn()
    }
    
    @IBAction func touchActiveBtn(_ sender: UIButton) {
        self.delegate?.responseToActiveBtn()
    }
    
    @IBAction func touchNextHouseBtn(_ sender: Any) {
        self.delegate?.responseToNextBtn(model: currentModel!)
        
        selectedCount += 1;
        if selectedCount == projectCount + 1 {
            nextHouseBtn.isHidden = true
        } else {
            nextHouseBtn.isHidden = false
            currentModel = projectModelArray?[selectedCount]
        }
    }
}
