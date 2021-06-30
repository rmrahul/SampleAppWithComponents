//
//  RMCustomButton.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 23/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import Foundation
import UIKit

class RMCustomButton: UIView {
    
    // MARK: Lifecycle
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        //Draw main body
        bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        

        bezierPath.move(to: CGPoint(x: rect.maxX - 25.0, y: rect.maxY + 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY - 10.0))

        
        //Draw the tail
//        if currentUserIsSender {
//            bezierPath.move(to: CGPoint(x: rect.maxX - 25.0, y: rect.maxY - 10.0))
//            bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY))
//            bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY - 10.0))
//        } else {
//            bezierPath.move(to: CGPoint(x: rect.minX + 25.0, y: rect.maxY - 10.0))
//            bezierPath.addLine(to: CGPoint(x: rect.minX + 10.0, y: rect.maxY))
//            bezierPath.addLine(to: CGPoint(x: rect.minX + 10.0, y: rect.maxY - 10.0))
//        }
        
        UIColor.lightGray.setFill()
        bezierPath.fill()
        bezierPath.stroke()
        bezierPath.close()
    }
    
    // MARK: Custom Accessors
    
    var currentUserIsSender = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
}

