//
//  DrawView.swift
//  TouchDraw
//
//  Created by Paul Vagner on 9/30/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    
    //array of lines
    var lines = [Line] ()
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    
    let context = UIGraphicsGetCurrentContext()

        UIColor.magentaColor().set()
        
        for line in lines {
            
            if let start = line.start, let end = line.end{
                
                // checks if line has fill color and does something with it
                if let fillColor = line.fillColor{
                    
                    fillColor.set()
                    //
                    if let shape = line as? Shape {
                        // "??" means default
                        let width = end.x - start.x
                        let height = end.y - start.y
                        
                        let rect = CGRect(x: start.x, y: start.y, width: width, height: height)
                        
                        switch shape.type ?? .Rectangle {
                            
                        case .Circle :
                        
                            CGContextFillEllipseInRect(context, rect)
                            
                        case .Triangle :
                        
                            let top = CGPoint(x: width / 2 + start.x ,y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x ,y: end.y)
                            
                            //moves cursor to a specific point
                            CGContextMoveToPoint(context, top.x, top.y)
                            //adds a line
                            CGContextAddLineToPoint(context, right.x, right.y)
                            // adds a line
                            CGContextAddLineToPoint(context, left.x, left.y)
                            // adds a line
                            CGContextAddLineToPoint(context, top.x, top.y) //closes triangle
                            // fills the shape on the inside
                            CGContextFillPath(context)
                            
                            
                            
                        case .Rectangle :
                        
                            CGContextFillRect(context, rect)
                            
                        case .Diamond :
                            
//                            
//                            let midx = CGRectGetMidX(rect)
//                            let midy = CGRectGetMidY(rect)
                            
                            let top = CGPoint(x: width / 2 + start.x, y: start.y)
                            let right = CGPoint(x: end.x, y: height / 2 + start.y)
                            let bottom = CGPoint(x: width / 2 + start.x, y: end.y)
                            let left = CGPoint(x: start.x, y: height / 2 + start.y)
                            
                            
                            //moves cursor to a specific point
                            CGContextMoveToPoint(context, top.x, top.y)
                            //adds a line
                            CGContextAddLineToPoint(context, right.x, right.y)
                            // adds a line
                            CGContextAddLineToPoint(context, bottom.x, bottom.y)
                            // adds a line
                            CGContextAddLineToPoint(context, left.x, left.y)
                            // adds a line
                            CGContextAddLineToPoint(context, top.x, top.y) //closes diamond
                            // fills the shape on the inside
                            CGContextFillPath(context)
                            
                            
                            
                            
                        }
                    }
                    
                }
                
                // checks if line has stroke color and applies it
                if let strokeColor = line.strokeColor {
                    
                    strokeColor.set()
                    
                    CGContextSetLineWidth(context, line.strokeWidth)
                    
                    CGContextSetLineCap(context, .Round)
                    CGContextSetLineJoin(context, .Round)
                    
                    
                    if let shape = line as? Shape {
                        
                        
                        // "??" means default
                        let width = end.x - start.x
                        let height = end.y - start.y
                        
                        let rect = CGRect(x: start.x, y: start.y, width: width, height: height)
                        
                        switch shape.type ?? .Rectangle {
                            
                        case .Circle :
                            
                            CGContextStrokeEllipseInRect(context, rect)
                            
                        case .Triangle :
                            
                            let top = CGPoint(x: width / 2 + start.x ,y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x ,y: end.y)
                            
                            //moves cursor to a specific point
                            CGContextMoveToPoint(context, top.x, top.y)
                            //adds a line
                            CGContextAddLineToPoint(context, right.x, right.y)
                            // adds a line
                            CGContextAddLineToPoint(context, left.x, left.y)
                            // adds a line
                            CGContextAddLineToPoint(context, top.x, top.y) //closes triangle
                            // fills the shape on the inside
                            CGContextFillPath(context)
                            
                            
                            
                        case .Rectangle :
                            
                            CGContextFillRect(context, rect)
                            
                        case .Diamond :
                            
                            //
                            //                            let midx = CGRectGetMidX(rect)
                            //                            let midy = CGRectGetMidY(rect)
                            
                            let top = CGPoint(x: width / 2 + start.x, y: start.y)
                            let right = CGPoint(x: end.x, y: height / 2 + start.y)
                            let bottom = CGPoint(x: width / 2 + start.x, y: end.y)
                            let left = CGPoint(x: start.x, y: height / 2 + start.y)
                            
                            
                            //moves cursor to a specific point
                            CGContextMoveToPoint(context, top.x, top.y)
                            //adds a line
                            CGContextAddLineToPoint(context, right.x, right.y)
                            // adds a line
                            CGContextAddLineToPoint(context, bottom.x, bottom.y)
                            // adds a line
                            CGContextAddLineToPoint(context, left.x, left.y)
                            // adds a line
                            CGContextAddLineToPoint(context, top.x, top.y) //closes diamond
                            // fills the shape on the inside
                            CGContextFillPath(context)
                            
                            
                            
                            
                        }
                        
                        
                    } else {
                        
                        
                        //creates start point for line
                        CGContextMoveToPoint(context, start.x, start.y)
    //                    //creates end poing for the line
    //                    CGContextAddLineToPoint(context, end.x, end.y)
    //                    // setting up to draw
    //                    CGContextStrokePath(context)
    //
    //                    if line is Scribble {
    //
    //                    }
                        
                        if let scribble = line as? Scribble {
                            
                            CGContextAddLines(context, scribble.points, scribble.points.count)
                            
                        }
                        
                        CGContextAddLineToPoint(context, end.x, end.y)
                        
                        
                        
                        CGContextStrokePath(context)
                        
                        
                    }
                    
                    
                    
                    
                }
                
            }
            
        }
        
        
        //        //sets color of object - circle
//        UIColor.magentaColor().set()
//        //creates filled circle
//        CGContextFillEllipseInRect(context, CGRect (x: 10, y: 10, width: 200, height: 100))
//        //sets color of object - square
//        UIColor.blueColor().set()
//        //creates outlined square
//        CGContextStrokeRect(context, CGRect (x: 200, y: 10, width: 100, height: 100))
//        
//        //creates the object - circle
//        CGContextAddEllipseInRect(context, CGRect(x: 100, y: 100, width: 200, height: 200))
//        //sets the color of the object
//        UIColor.cyanColor().set()
//        //fills the object with color chosen
//        CGContextFillPath(context)
//        // creates the opject - circle
//        CGContextAddEllipseInRect(context, CGRect(x: 20, y: 20, width: 200, height: 200))
//        //fills the object with color chosen
//        CGContextFillPath(context)
//        //sets color of the object
//        UIColor.magentaColor().set()
//        // creates the opject - circle
//        CGContextAddEllipseInRect(context, CGRect(x: 50, y: 50, width: 200, height: 200))
//        //fills the object with color chosen
//        CGContextFillPath(context)
//
        
//          sets color of the object
//        UIColor.blueColor().set()
//       
//        moves the cursor to a new location
//       CGContextMoveToPoint(context,20, 20)
//        
//    adds a line to the drawing starting at point
//        CGContextAddLineToPoint(context, 100, 100)
//        lifts pencil and repositions to new location at point
//       CGContextMoveToPoint(context, 200, 200)
//        adds a line to the drawing starting at point
//        CGContextAddLineToPoint(context, 200, 100)
//        fills the stroke
//        CGContextStrokePath(context)
//
//    
    
        
        UIColor.blueColor()
        
    }

}



class Line {
    
    //sets location of the object
    var start: CGPoint?
    var end: CGPoint?
    //sets color values for the object
    var strokeColor: UIColor?
    var fillColor: UIColor?
    //sets the thicknes of the stroke
    var strokeWidth: CGFloat = 0
    
}

    //this subclass allows access to the "Line" array in the class "DrawView"
class Scribble: Line {
    
    var points = [CGPoint] () {
        
        didSet {
        
            
            //adds a new point to the previous point as a line.
            start = points.first
            end = points.last
            
            
            
            
        }
        
    }
}
// creates set of allowable parameters
enum ShapeType {
    
        // creates the allowable shape types
        case Rectangle, Circle, Triangle, Diamond
    
}
// creates a new class for the Shape - "Line" is subclass
class Shape: Line{
    //sets the variable of types as ShapeType
    var type: ShapeType!
    //initializer
    init(type: ShapeType) {
      //
        self.type = type
        
        
    }
    
}

