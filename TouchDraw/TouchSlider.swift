//
//  TouchSlider.swift
//  CustomSlider
//
//  Created by Paul Vagner on 10/2/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit
//renders in storyboard what is coded.
@IBDesignable
class TouchSlider: UIView {
    // sets the color of the slider bar (just the bar, not the handle)
    @IBInspectable var barColor: UIColor = UIColor.purpleColor()
    // renders the color of the slider handle (just the handle, not the bar)
    @IBInspectable var handleColor: UIColor = UIColor.blueColor()
    
    
    // allows access to the value of the slider.
    @IBInspectable var  value: CGFloat = 0 {
        //listens to when a value is set on the slider.
        didSet {
            // forces the slider to stop at the min and max values without going over.
            
            if value < minValue { value = minValue }
            if value > maxValue { value = maxValue }
            
            //re-draws the slider when a new value is set (when the finer is moved, the slider is re-drawn with the handle in the new position.
            setNeedsDisplay()
            
        }
    }
    //grants access to the variables using the inspector panel
    @IBInspectable var minValue: CGFloat = 0
    @IBInspectable var maxValue: CGFloat = 100
    
    
    
    
    override func drawRect(rect: CGRect) {
        //"context" - what you are drawing on
        let context = UIGraphicsGetCurrentContext()
        //".set" sets the bar color
        barColor.set()
        
        CGContextMoveToPoint(context, 0, rect.height / 2)
        
        CGContextAddLineToPoint(context, rect.width, rect.height / 2)
        
        CGContextStrokePath(context)
        //".set" sets the handle color
        handleColor.set ()
        
        //        CGContextAddEllipseInRect(context, handleRect)
        
        
        CGContextFillEllipseInRect(context, handleRect)
        
        //superimposes one item on top of another
        CGContextSetBlendMode(context, .Clear)
        
        //fills the shape and insets one item into another
        CGContextFillEllipseInRect(context, CGRectInset (handleRect, 2, 2))
        
        CGContextSetBlendMode(context, .Normal)
        
        CGContextFillPath(context)
    }
    
    
    var handleRect: CGRect {
        
        //handleRect
        let handleX = (bounds.width - bounds.height) * (value / maxValue)
        
        
        return CGRect(x: handleX, y: 0, width: bounds.height, height: bounds.height)
        
        
    }
    // boolion should be named with "is"
    var isTouchingHandle = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            // where was the touch within that view happens
            let locPoint = touch.locationInView(self)
            
            isTouchingHandle = CGRectContainsPoint(handleRect, locPoint)
            
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if isTouchingHandle {
            
            if let touch = touches.first {
                
                
                let touchX = touch.locationInView(self).x
                //center of the button (radius removed from button to allow the exact point of "0")
                let removeRadius = touchX - bounds.height / 2
                // sets the range that the slider can travel.
                let fullDistance = bounds.width - bounds.height
                
                let percent = removeRadius / fullDistance
                
                value = percent * maxValue
                
                
                
            }
        }
        
        
    }
    
    
}



//@IBInspectable var thiIsAPoint: CGPoint = CGPointZero
//@IBInspectable var thisIsCoolRect: CGRect = CGRectZero

