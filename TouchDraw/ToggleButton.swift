//
//  ToggleButton.swift
//  TouchDraw
//
//  Created by Paul Vagner on 10/1/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

// THIS CODE CREATES AND RENDERS THE DROPDOWN/"TOGGLE" BUTTON
import UIKit
//renders the button in the main storyboard
@IBDesignable

class ToggleButton: UIButton {
    //sets strokeWidth
    @IBInspectable var strokeWidth: CGFloat = 1
    //sets inset of the circle in the square button
    @IBInspectable var circleInset: CGFloat = 10
    
    
    override func drawRect(rect: CGRect) {
    
        let context =  UIGraphicsGetCurrentContext()

        let insetRect = CGRectInset(rect, circleInset, circleInset)
        
    tintColor.set()
        
        CGContextSetLineWidth(context, strokeWidth)
        
        CGContextStrokeEllipseInRect(context, insetRect)
        
        let midX = CGRectGetMidX(rect)
        let midY = CGRectGetMidY(rect)
        
        //sets the first point in the circle inset of the square button
        CGContextMoveToPoint(context, circleInset + 10, midY - 4)
        //sets the middle point of the arrow within the circle in the square button
        CGContextAddLineToPoint(context, midX, midY + 7)
        
        CGContextAddLineToPoint(context, rect.width - circleInset - 10, midY - 4)
        
        CGContextStrokePath(context)

        
    }
    
}
