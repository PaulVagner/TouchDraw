//
//  ViewController.swift
//  TouchDraw
//
//  Created by Paul Vagner on 9/30/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    
    
    //creates outlet for the view
    @IBOutlet weak var controlPanelView: UIView!
    //constraint of the dropdown menu
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    //button action
    @IBAction func toggleControlPanel(sender: AnyObject) {
        
        
        //toggles the control of the view when the button is pressed... (I.E. edits the constraints of the view.)
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -200 : 0
        view.setNeedsUpdateConstraints()
        
        
        
        //animates the dropdown window.
        UIView.animateWithDuration(0.8) { () -> Void in
            
         self.view.layoutIfNeeded()
        
        }
    
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            // LINE
            
            //            let newLine = Line()
            //
            //
            //            //let locPoint = touch.locationInView(view)
            //
            //            newLine.start = touch.locationInView(view)
            //
            //            newLine.strokeColor = UIColor.blackColor()
            //            newLine.strokeWidth = 10
            //
            //
            //            //look at View as DrawView if not, then will not crash
            //            (view as? DrawView)?.lines.append(newLine)
            
            
            
            // SCRIBBLE
            
            //            let newScribble = Scribble()
            //
            //            newScribble.points.append(touch.locationInView(view))
            //
            //            newScribble.strokeColor = UIColor.blackColor()
            //            newScribble.strokeWidth = 5
            //
            //            (view as? DrawView)?.lines.append(newScribble)
            
            //SHAPE)
                
                
            // initializing shape
            let shape = Shape(type: .Circle)
            // sets start location of the shape (top left corner of the shape)
            shape.start = touch.locationInView(view)
            // sets color of the shape
            shape.fillColor = UIColor.purpleColor()
            
            (view as? DrawView)?.lines.append(shape)
            
            
            view.setNeedsDisplay()
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            
            //LINE
            
            //            if let currentLine = (view as? DrawView)?.lines.last {
            //
            //                currentLine.end = touch.locationInView(view)
            //
            //                view.setNeedsDisplay()
            //
            //
            //
            //            }
            
            
            
            
            //SCRIBBLE
            //            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
            //                
            //                currentScribble.points.append(touch.locationInView(view))
            //                
            //                view.setNeedsDisplay()
            //                
            //            }
            //        
            
            
            if let currentShape = (view as? DrawView)?.lines.last {
                
                currentShape.end = touch.locationInView(view)
                
                view.setNeedsDisplay()
                
                
            }
            
        }
    }
}


