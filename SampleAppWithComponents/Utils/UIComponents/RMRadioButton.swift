//
//  RMRadioButton.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

enum RMRadioButtonState{
    case normal
    case selected
}

protocol RMRadioButtonDelegate : AnyObject {
    func didSelect(radio : RMRadioButton)
    func didUnSelect(radio : RMRadioButton)
}

class RMRadioButton: UIView {
    let kCONTENT_XIB_NAME = "RMRadioButton"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgRadioIcon: UIImageView!
    
    private var state = RMRadioButtonState.normal;
    
    weak var delegate : RMRadioButtonDelegate?
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        refreshUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        borderView.addGestureRecognizer(tap)
    }
    
    private func setUpBorder(color : UIColor, borderColor : UIColor){
        borderView.backgroundColor = color
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = borderColor.cgColor
        borderView.layer.cornerRadius = 5.0
    }
    
    func updateBackgroundColor(color : UIColor){
        self.backgroundColor = color
        self.borderView.backgroundColor = color
        self.contentView.backgroundColor = color
    }
    
    func setState(s : RMRadioButtonState) {
        state = s
        refreshUI()
    }
    
    func refreshUI() {
        switch state {
        case .normal:
            let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                              NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
            
            self.lblTitle.attributedText = NSAttributedString(string: self.lblTitle.attributedText?.string ?? "",attributes: attributes)
            
            self.imgRadioIcon.image = UIImage(named: "radioUnSelected")
            setUpBorder(color: UIColor(hexString: "#E9E8E9")!, borderColor: UIColor.lightGray)
//            self.bgImageView.image = UIImage(named: "nonselectedBg")
//            borderView.backgroundColor = UIColor.clear
            break
        case .selected:
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                              NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
            
            self.lblTitle.attributedText = NSAttributedString(string: self.lblTitle.attributedText?.string ?? "",attributes: attributes)
            self.imgRadioIcon.image = UIImage(named: "radioSelected")
            setUpBorder(color: UIColor(hexString: "#F19336")!, borderColor: UIColor.lightGray)
            //self.bgImageView.image = UIImage(named: "selectedRadioBg")
            
//            if(self.lblTitle.attributedText?.string == "Others"){
//                self.bgImageView.image = UIImage(named: "selectedOthersbg")
//            }
//            borderView.backgroundColor = UIColor.clear
        }
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton) {
        
        sender.isSelected = true
        state = RMRadioButtonState.selected
        
        delegate?.didSelect(radio: self)
        
        /*
         if(sender.isSelected){
         sender.isSelected = false
         state = RMRadioButtonState.normal
         
         delegate?.didUnSelect(radio: self)
         }
         else{
         sender.isSelected = true
         state = RMRadioButtonState.selected
         
         delegate?.didSelect(radio: self)
         }
         */
        
        refreshUI()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        btnClicked(btnRadio)
    }
}
