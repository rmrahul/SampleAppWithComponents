//
//  StepperTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 23/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

struct StepperTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var text : String?
    var textColor : UIColor?
    var enable : Bool?
    
    var hideTitle : Bool?
    var title : NSAttributedString?
    
    var hideInfo : Bool?
    var hideErrorIcon : Bool?
    var errorBackgrounColor : UIColor?
    
    
    var options : [NSAttributedString]?
    var selectedColor : UIColor?
    var normalColor : UIColor?
    var numberOfColumn : Int = 1
    var spacing : CGFloat?
    var spacingBetweenColumn : CGFloat?
    var checkOthersOption : Bool?
}


class StepperTableViewCell: UITableViewCell {
    @IBOutlet weak var verticalStackview: UIStackView!
    @IBOutlet weak var lblErrorLabel: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var imgErrorIcon: UIImageView!
    
    private var myConfig : StepperTableViewCellConfig?
    private var myIndexPath : IndexPath?
    weak var delegate : RadioBoxGroupTableViewCellDelegate?
    var selectedOption : String = ""

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showError(error : NSAttributedString?){
        if let e = error, e.length != 0 {
            self.lblErrorLabel.isHidden = false
            self.lblErrorLabel.attributedText = e
            
            
            if let bgColor = myConfig?.errorBackgrounColor{
                self.contentView.backgroundColor = bgColor
            }
            else{
                self.contentView.backgroundColor = UIColor.clear
            }
            
            if let hideerror = myConfig?.hideErrorIcon{
                imgErrorIcon.isHidden = hideerror
            }
            else{
                imgErrorIcon.isHidden = true
            }
        }
        else{
            self.lblErrorLabel.isHidden = true
            self.contentView.backgroundColor = UIColor.clear
            self.imgErrorIcon.isHidden = true
        }
    }
    
    func configureCell(config : StepperTableViewCellConfig?, indexPath : IndexPath){
        myIndexPath = indexPath
        myConfig = config
        if let insets = config?.insets{
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        if let options = config?.options{
            addDynamicTextfields(options: options, column: config?.numberOfColumn ?? 1)
        }
        
        if let spacing = config?.spacing{
            self.verticalStackview.spacing = spacing
        }
        
        if let title = myConfig?.title{
            self.lblTitle.attributedText = title
        }
        else{
            self.lblTitle.text = ""
        }
    }
    
    private func addDynamicTextfields(options : [NSAttributedString], column: Int){
        self.verticalStackview.arrangedSubviews.forEach { (view) in
            self.verticalStackview.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        let optionsPerRow = options.chunked(by: column)
        optionsPerRow.forEach { (optionsInRow) in
            var viewsPerRow = optionsInRow.map({ (option) -> UIView in
                return getStepper(option: option)
            })
            
            if(viewsPerRow.count < column){
                let minView = column - viewsPerRow.count
                for _ in stride(from: 0, through: minView-1, by: 1) {
                    viewsPerRow.append(UIView())
                }
            }
            
            let stackView = UIStackView(arrangedSubviews: viewsPerRow)
            stackView.axis = NSLayoutConstraint.Axis.horizontal
            stackView.distribution = UIStackView.Distribution.fillEqually
            stackView.alignment = UIStackView.Alignment.fill
            stackView.spacing = myConfig?.spacingBetweenColumn ?? 5
            self.verticalStackview.addArrangedSubview(stackView)
        }
        
        
    }
    
    func getStepper(option : NSAttributedString) -> BQStepper {
        let stepper = BQStepper(frame:  CGRect(x: 0, y: 0, width: 0, height: 0 ))
        stepper.lblTitle.attributedText = option
        return stepper
    }
    
    
    func didSelect(radio: RMRadioButton) {
        selectedOption = radio.lblTitle.attributedText?.string ?? ""
        markOthersAsNonSelected(radio : radio)
        delegate?.didSelectOption(indexPath: myIndexPath!, option: selectedOption)
    }
    
    func didUnSelect(radio: RMRadioButton) {
        
    }
    
    private func markOthersAsNonSelected(radio: RMRadioButton){
        self.verticalStackview.arrangedSubviews.forEach { (perRowView) in
            let stackView = perRowView as? UIStackView
            stackView?.arrangedSubviews.forEach({ (option) in
                let rm = option as? RMRadioButton
                if(rm != radio){
                    rm?.setState(s: RMRadioButtonState.normal)
                }
            })
        }

    }
    
    
    
    @objc func otherOptionDidChange(textfield : UITextField){
        selectedOption = textfield.text ?? ""
        delegate?.didSelectOption(indexPath: myIndexPath!, option: selectedOption)
    }
    
}
