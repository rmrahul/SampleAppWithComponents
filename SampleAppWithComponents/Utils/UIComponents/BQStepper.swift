//
//  BQStepper.swift
//  FlyNearMe
//
//  Created by Priyanka Gaikwad on 20/09/19.
//  Copyright © 2019 Priyanka Gaikwad. All rights reserved.
//

import UIKit

protocol BQStepperDelegate : AnyObject {
    func didPlus()
    func didMinus()
}

class BQStepper: UIView {

    let kSTEPPER_XIB_NAME = "BQStepper"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var borderStackView: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var txtSelectedValue: UITextField!
    
    @IBOutlet weak var borderView: UIView!
    var defaultValue = 0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kSTEPPER_XIB_NAME, owner: self, options: nil)
        // FixMe:: Please check this fixInView is needed or not
        contentView.fixInView(self)
        setUpBorder(color: UIColor.clear, borderColor: UIColor.lightGray)
    }
    
    private func setUpBorder(color : UIColor, borderColor : UIColor){
        borderView.backgroundColor = color
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = borderColor.cgColor
        borderView.layer.cornerRadius = 5.0
    }
    
    @IBAction func minusAction(_ sender: Any) {
        guard let currentValue = Int(txtSelectedValue.text!) else { return }
        if currentValue > defaultValue {
            txtSelectedValue.text = "\(currentValue - 1)"
        }
    }
    
    @IBAction func plusAction(_ sender: Any) {
        guard let currentValue = Int(txtSelectedValue.text!) else { return }
        if currentValue < defaultValue {
            txtSelectedValue.text = "\(currentValue - 1)"
        }
    }
}
