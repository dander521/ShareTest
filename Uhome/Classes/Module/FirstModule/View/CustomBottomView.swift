//
//  CustomBottomView.swift
//  Uhome
//
//  Created by 程荣刚 on 2017/8/7.
//  Copyright © 2017年 menhao. All rights reserved.
//

import UIKit

public protocol CustomBottomViewDelegate {
    func responseToQuestionBtn()
    func responseToLocationBtn()
    func responseToQrcodeBtn()
    func responseToPersonalBtn()
    func responseToActiveBtn()
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
        self.delegate?.responseToQrcodeBtn()
    }
    
    @IBAction func touchPersonalBtn(_ sender: UIButton) {
        self.delegate?.responseToPersonalBtn()
    }
    
    @IBAction func touchActiveBtn(_ sender: UIButton) {
        self.delegate?.responseToActiveBtn()
    }
}
