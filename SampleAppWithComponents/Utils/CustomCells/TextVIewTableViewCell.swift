//
//  TextViewTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Perennial on 13/12/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

struct TextViewTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var textViewText : NSAttributedString?
    var alignment : NSTextAlignment?
}

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.perform(#selector(self.adjustContentOffset), with: nil, afterDelay: 0.1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func adjustContentOffset() {
        //textView.isScrollEnabled = true
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func configureCell(config : TextViewTableViewCellConfig?){
        textView.setContentOffset(CGPoint.zero, animated: false)
        textView.scrollRangeToVisible(NSMakeRange(0, 1))
        if let insets = config?.insets  {
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        if let text = config?.textViewText  {
            textView.attributedText = text
        }
        
        if let alignment = config?.alignment{
            textView.textAlignment = alignment
        }
        
        if let bgColor = config?.backgroundColor {
            textView.backgroundColor = bgColor
        }
    }
    
}
