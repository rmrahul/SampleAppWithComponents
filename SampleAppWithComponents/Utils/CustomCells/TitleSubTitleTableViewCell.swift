//
//  TitleSubTitleTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 24/12/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
struct TitleSubTitleTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    
    var titles: [NSAttributedString]?
}

class TitleSubTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var verticalStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(config : TitleSubTitleTableViewCellConfig?){
        if let titleValues = config?.titles {
            //self.verticalStackView.removeAllArrangedSubviews()
            self.verticalStackView.spacing = 10
            titleValues.forEach { (title) in
                let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
                label1.attributedText = title
                label1.translatesAutoresizingMaskIntoConstraints = false
                label1.numberOfLines = 0

                self.verticalStackView.addArrangedSubview(label1)
            }
        }
    }
}
