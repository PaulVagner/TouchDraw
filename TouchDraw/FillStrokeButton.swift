//
//  FillStrokeButton.swift
//  TouchDraw
//
//  Created by Paul Vagner on 10/3/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit
//allows for direct rendering to the "Main.storyboard"
@IBDesignable
    //creates a class instance of "fillStrokeButton" which is UIButton type = creates a UIButton named fillStrokeButton
    class fillStrokeButton: UIButton {
    
    //sets the thickness of the object outline (stroke)
    @IBInspectable var strokeWidth: CGFloat = 4
    
    //sets inset of the object/circle in the sized View - square/rectangle UIbutton
    @IBInspectable var circleInset: CGFloat = 6
    
    //sets the color of the outer object/circle
    @IBInspectable var outerColor: UIColor = UIColor.blackColor()
    
    //sets the color of the inner object/circle
    @IBInspectable var innerColor: UIColor = UIColor.redColor()
    
    
    @IBInspectable var iconInset: CGFloat  = 0
    
    
    override func drawRect(rect: CGRect) {
        
        let context =  UIGraphicsGetCurrentContext()
        
        let insetRect = CGRectInset(rect, circleInset, circleInset)
        
        
        outerColor.set()
        
        CGContextSetLineWidth(context, strokeWidth)
        //sets up to draw a line within the rectangle (line is circular)
        CGContextStrokeEllipseInRect(context, CGRectInset(rect, circleInset,circleInset))
    
        
        innerColor.set()
        //sets up to draw a filled shape within the inset rectangle of the main rectangle (shape is circular)
        CGContextFillEllipseInRect(context, CGRectInset(rect, circleInset + iconInset, circleInset + iconInset))
        
        
        
        }
    
  
     let context = UIGraphicsGetCurrentContext()
    
    var circleRect: CGRect {
            
            //this sets up the position of the object/circle.
            let circleX = (bounds.width - bounds.height)
            
            
        
        
        //this draws the object/circle with a particular set of dimentions. (x: uses the position stated in "circleX". since width and height are set by the same parameter, they will form a square.
        return CGRect(x: circleX, y: 0, width: bounds.height, height: bounds.height)
        
        
    }
    

}