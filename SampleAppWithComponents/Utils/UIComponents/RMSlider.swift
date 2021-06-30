//
//  RMSlider.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 23/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import Foundation
import UIKit

class RMSlider: UISlider {
    
    @IBInspectable var thumbImage: UIImage?
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let thumbImage = thumbImage {
            self.setThumbImage(thumbImage, for: .normal)
        }
    }
}

