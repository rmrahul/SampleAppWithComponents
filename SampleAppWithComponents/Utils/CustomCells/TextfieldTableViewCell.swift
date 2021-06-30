//
//  TextfieldTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 17/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

struct TextfieldTableViewCellConfig : BaseCellConfig {
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
    
    var size : CGSize?
}

class TextfieldTableViewCell: UITableViewCell {
    @IBOutlet weak var textfield: RMTextfieldView!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var imgErrorIcon: UIImageView!
    
    private var myConfig : TextfieldTableViewCellConfig?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showError(str : NSAttributedString){
        if(str.string.isEmpty){
            //hide
            self.textfield.hideError()
            self.contentView.backgroundColor = UIColor.clear
            self.imgErrorIcon.isHidden = true
        }
        else{
            self.textfield.showError(str: str)
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
    }
    
    
    func configureCell(config : TextfieldTableViewCellConfig?){
        myConfig = config
        
        if let insets = config?.insets{
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        textfield.updatePlaceholder(placeHolder:config?.placeHolder ?? "")
        
        if let bgColor = config?.backgroundColor {
            textfield.backgroundColor = bgColor
            textfield.updateBackgroundColor(color: bgColor)
        }
        
        textfield.textfield.textColor = config?.textColor ?? AppManager.appStyle.color(for: .title)
        
        if let enable = config?.enable{
            textfield.textfield.isEnabled = enable
            textfield.textfield.textColor = config?.textColor?.withAlphaComponent(0.50) ?? AppManager.appStyle.color(for: .title)
        }
        
        
        
        textfield.textfield.font = AppManager.appStyle.font(for: .title)
        textfield.placeholder.font = AppManager.appStyle.font(for: .placeHolder)
        textfield.placeholder.textColor = AppManager.appStyle.color(for: .placeHolder)
        textfield.lblError.font = AppManager.appStyle.font(for: .error)
        textfield.lblError.textColor = AppManager.appStyle.color(for: .error)
        
        if let text = config?.text{
            textfield.setText(text: text)
        }
        
        if let text = config?.title{
            lblTitle.attributedText = text
        }
        
        if let hideTitile = config?.hideTitle{
            lblTitle.isHidden = hideTitile
        }
        
//        if let hideinfo = config?.hideInfo{
//            btnInfo.isHidden = hideinfo
//        }
        
//        if let hideError = config?.hideErrorIcon{
//            imgErrorIcon.isHidden = hideError
//
//            if let bgColor = config?.backgroundColor, hideError == true{
//                self.backgroundColor = bgColor
//            }
//            else{
//                self.backgroundColor = UIColor.clear
//            }
//        }
    }
}
