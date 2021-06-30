//
//  BloodSugarTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 23/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

struct BloodSugarTableViewCellConfig : BaseCellConfig {
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


class BloodSugarTableViewCell: UITableViewCell {

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
    
    private var myConfig : BloodSugarTableViewCellConfig?
    private var myIndexPath : IndexPath?

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
    
    func configureCell(config : BloodSugarTableViewCellConfig?, indexPath : IndexPath){
        myIndexPath = indexPath
        myConfig = config
        if let insets = config?.insets{
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        if let spacing = config?.spacing{
            self.verticalStackview.spacing = spacing
        }
        
        if let title = myConfig?.title{
            self.lblTitle.attributedText = title
        }
    }
    
    
}
