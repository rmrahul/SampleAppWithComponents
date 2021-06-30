//
//  TwoLabelTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 14/02/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit
struct TwoLabelTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var title : NSAttributedString?
    var subtitle : NSAttributedString?
    
    var bgImageColor : UIColor?
}

class TwoLabelTableViewCell: UITableViewCell {
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(config : TwoLabelTableViewCellConfig?){
        if let insets = config?.insets  {
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        if let text = config?.title  {
            lblTitle.attributedText = text
        }
        
        if let text = config?.subtitle  {
            lblSubTitle.attributedText = text
        }
        
        if let value = config?.bgImageColor{
            let image = UIImage(named:"rectangle3741Copy")?.withRenderingMode(.alwaysTemplate)
            self.bgImageView.tintColor = value
            self.bgImageView.image = image
        }
        else{
            let image = UIImage(named:"rectangle3741Copy")
            self.bgImageView.image = image
        }
        
    }
}
