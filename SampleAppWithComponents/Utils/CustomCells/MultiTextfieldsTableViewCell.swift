//
//  MultiTextfieldsTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

struct MultiTextfieldsTableViewCellConfig : BaseCellConfig {
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
    
    
    var textfields : [TextfieldTableViewCellConfig]?
    var spacingBetweenTextfieilds : CGFloat?
}

class MultiTextfieldsTableViewCell: UITableViewCell {
    @IBOutlet weak var horizontalStackview: UIStackView!

    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var imgErrorIcon: UIImageView!
    
    private var myConfig : MultiTextfieldsTableViewCellConfig?
    var innerVerticalStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func showError(str : NSAttributedString){
        
    }
    
    
    
    func configureCell(config : MultiTextfieldsTableViewCellConfig?){
        myConfig = config
        if let insets = config?.insets{
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        if let textfieldConfigs = config?.textfields{
            addDynamicTextfields(configs: textfieldConfigs)
        }
        
        if let spacing = config?.spacingBetweenTextfieilds{
            self.horizontalStackview.spacing = spacing
        }
    }
    
    
    private func addDynamicTextfields(configs : [TextfieldTableViewCellConfig]){
        self.horizontalStackview.arrangedSubviews.forEach { (view) in
            self.horizontalStackview.removeArrangedSubview(view)
        }
        
       var stackViews  =  configs.map { (config) -> UIStackView in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            label.attributedText = config.title
            
            let txtField = RMTextfieldView(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
            txtField.textfield.font = AppManager.appStyle.font(for: .title)
            txtField.placeholder.font = AppManager.appStyle.font(for: .placeHolder)
            txtField.placeholder.textColor = AppManager.appStyle.color(for: .placeHolder)
            txtField.lblError.font = AppManager.appStyle.font(for: .error)
            txtField.lblError.textColor = AppManager.appStyle.color(for: .error)
            txtField.textfield.isEnabled = config.enable ?? true
            txtField.textfield.textColor = config.textColor?.withAlphaComponent(0.50) ?? AppManager.appStyle.color(for: .title)
            //txtField.updateBackgroundColor(color: config.backgroundColor ?? UIColor.clear)
            txtField.layer.cornerRadius = 5
            txtField.layer.borderWidth = 0
            txtField.clipsToBounds = true
            txtField.borderView.layer.borderColor = UIColor.clear.cgColor
            txtField.borderView.backgroundColor = config.backgroundColor ?? UIColor.clear
        
            if let text = config.text{
                txtField.setText(text: text)
            }
        
        
        let stackView = UIStackView(arrangedSubviews: [label, txtField])
            stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.distribution = UIStackView.Distribution.fill
            stackView.alignment = UIStackView.Alignment.fill
        
            self.horizontalStackview.addArrangedSubview(stackView)
            return stackView
        }
    }
}
