//
//  ImageLabelTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 15/12/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

struct ImageLabelTableViewCellConfig : BaseCellConfig {
    var backgroundColor: UIColor?
    var insets : UIEdgeInsets?
    
    var icon : UIImage?
    var title : NSAttributedString?
    
    var isBGRequired : Bool?
}

class ImageLabelTableViewCell: UITableViewCell {
    var indexPath : IndexPath?
    @IBOutlet weak var imageIconView: UIImageView?
    @IBOutlet weak var imageRoundedBG: UIImageView?
    
    @IBOutlet weak var lblTitle: UILabel?
    
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    @IBOutlet weak var topOfContent: NSLayoutConstraint!
    @IBOutlet weak var bottomOfContent: NSLayoutConstraint!
    @IBOutlet weak var bottomOfSeperator: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(config : ImageLabelTableViewCellConfig?,indexPath: IndexPath){
        self.clipsToBounds = true
        self.indexPath = indexPath
    
        if let insets = config?.insets  {
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
            
            if(insets.top > 0){
                topOfContent.constant = insets.top + 10
            }
            else{
                topOfContent.constant = 10
            }
            
            if(insets.bottom > 0){
                bottomOfContent.constant = insets.bottom + 10 + 5
               // bottomOfSeperator.constant = -1
            }
            else{
                bottomOfContent.constant = 10
                //bottomOfSeperator.constant = insets.bottom * -1
            }
            
        }
     
        self.lblTitle?.attributedText = config?.title
        self.imageIconView?.image = config?.icon
        
        if let bg = config?.isBGRequired, bg == false{
            imageRoundedBG?.isHidden = true
            imageRoundedBG?.removeFromSuperview()
        }
        else{
            imageRoundedBG?.isHidden = false
        }
    }
}
