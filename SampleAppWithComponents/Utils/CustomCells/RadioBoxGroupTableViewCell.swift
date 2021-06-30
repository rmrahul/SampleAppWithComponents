//
//  RadioBoxGroupTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

struct RadioBoxGroupTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var placeHolder : String?
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

protocol RadioBoxGroupTableViewCellDelegate : AnyObject {
    func didSelectOption(indexPath : IndexPath, option : String?)
    func didAddOtherTextfieid(indexPath : IndexPath)
}

class RadioBoxGroupTableViewCell: UITableViewCell, RMRadioButtonDelegate {
    @IBOutlet weak var verticalStackview: UIStackView!
    @IBOutlet weak var lblErrorLabel: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var imgErrorIcon: UIImageView!
    
    var txtInputField: RMTextfieldView?

    private var myConfig : RadioBoxGroupTableViewCellConfig?
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
    
    func configureCell(config : RadioBoxGroupTableViewCellConfig?, indexPath : IndexPath){
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
    }
    
    private func addDynamicTextfields(options : [NSAttributedString], column: Int){
        self.verticalStackview.arrangedSubviews.forEach { (view) in
            self.verticalStackview.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        var stackView : UIStackView?
        let optionsPerRow = options.chunked(by: column)
        optionsPerRow.forEach { (optionsInRow) in
            var viewsPerRow = optionsInRow.map({ (option) -> UIView in
                return getRadioButton(option: option)
            })
            
            if(viewsPerRow.count < column){
                let minView = column - viewsPerRow.count
                for _ in stride(from: 0, through: minView-1, by: 1) {
                    viewsPerRow.append(UIView())
                }
            }
            
            stackView = UIStackView(arrangedSubviews: viewsPerRow)
            stackView?.axis = NSLayoutConstraint.Axis.horizontal
            stackView?.distribution = UIStackView.Distribution.fillEqually
            stackView?.alignment = UIStackView.Alignment.fill
            stackView?.spacing = myConfig?.spacingBetweenColumn ?? 5
            self.verticalStackview.addArrangedSubview(stackView!)
        }        
    }
    
    func getRadioButton(option : NSAttributedString) -> RMRadioButton {
        let button = RMRadioButton(frame:  CGRect(x: 0, y: 0, width: 0, height: 0 ))
        button.lblTitle.attributedText = option
        button.delegate = self
        return button
    }
    
    
    func didSelect(radio: RMRadioButton) {
        selectedOption = radio.lblTitle.attributedText?.string ?? ""
        markOthersAsNonSelected(radio : radio)
        handleOthersOption(radio: radio)
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
        if let textfield = txtInputField{
            textfield.removeFromSuperview();
            self.verticalStackview.removeArrangedSubview(textfield)
        }
    }
    
    private func handleOthersOption(radio: RMRadioButton){
        guard let checkOthers = myConfig?.checkOthersOption, checkOthers == true else {
            return
        }
        
        guard let title = radio.lblTitle.attributedText?.string,title == "Others" else{
            return
        }
        txtInputField = RMTextfieldView(frame: CGRect.zero)
        txtInputField?.updateBackgroundColor(color: UIColor.clear)
        txtInputField?.textfield.backgroundColor = UIColor.white
        txtInputField?.borderView.backgroundColor = UIColor.white
        
        txtInputField?.textfield.addTarget(self, action: #selector(self.otherOptionDidChange), for: .editingChanged)

        self.verticalStackview.addArrangedSubview(txtInputField!)
        selectedOption = ""
        self.delegate?.didAddOtherTextfieid(indexPath: myIndexPath!)
    }
    
    
    @objc func otherOptionDidChange(textfield : UITextField){
        selectedOption = textfield.text ?? ""        
        delegate?.didSelectOption(indexPath: myIndexPath!, option: selectedOption)
    }
}
