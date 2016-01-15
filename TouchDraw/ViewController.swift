//  ViewController.swift
//  TouchDraw
//
//  Created by Paul Vagner on 9/30/15.


import UIKit
import Foundation

class ViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var colorPallete: UICollectionView!
    @IBOutlet weak var fsButton: fillStrokeButton!
    //creates the button action outlet
    @IBOutlet weak var toggleButton: ToggleButton!
    //creates outlet for the view
    @IBOutlet weak var controlPanelView: UIView!
    //constraint of the dropdown menu
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    //button action
    @IBAction func toggleControlPanel(sender: UIButton) {
        //toggles the control of the view when the button is pressed... (I.E. edits the constraints of the view.) and moves the entire view out of the way
        controlPanelTop.constant = controlPanelView.frame.origin.y == 0 ? -200 : 0
        view.setNeedsUpdateConstraints()
        let degrees: CGFloat = controlPanelView.frame.origin.y == 0 ? 0 : 180
        //animates the dropdown window.
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded()
            //Animates the dropdown window /Toggle button.
            let degreesToRadians: (CGFloat) -> CGFloat = {
                return $0 / 180.0 * CGFloat(M_PI)
            }
            
            let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
            self.toggleButton.transform = t
    
        }
        
    }
    
    @IBAction func fsButton(sender: fillStrokeButton) {
        colorSource.isFill = !colorSource.isFill
        colorPallete.reloadData()
        
    }
    
    
    @IBAction func undo(sender: AnyObject) {
        
        if(view as? DrawView)?.lines.count > 0 {
            
            (view as? DrawView)?.lines.removeLast()
            
        }
        
        view.setNeedsDisplay()
        
        
    }
    
    @IBAction func clear(sender: AnyObject) {
        
        (view as? DrawView)?.lines = []
        
        view.setNeedsDisplay()
        
    }
    
    
    let colorSource = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelTop.constant = -200
        
        
        colorPallete.delegate = self
        colorPallete.dataSource = colorSource
        
//        print(colorPallete.dataSource)
        
        colorPallete.reloadData()
        
    }
    
    
    var chosenTool: Int = 0
    
    
    @IBAction func chooseTool(button: UIButton) {
        
        chosenTool = button.tag
        
    }
    
    var strokeWidth: CGFloat = 0
    //This code controls the thickness of the stroke using the UISlider
    @IBAction func changeStrokeWidth(sender: TouchSlider) {
        
        strokeWidth = CGFloat(sender.value * 10)
        
    }
    
    var chosenFillColor: UIColor = UIColor.redColor()
    var chosenStrokeColor: UIColor = UIColor.blackColor()
    //THIS FUNCTION SETS UP THE FILLSTROKEBUTTON TO USE THE COLORS FROM THE COLORPALLETE AS THE COLORS OF THE BUTTON DEPENDING ON ITS MODE OF OPERATION (STROKE OR FILL)
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
        if colorSource.isFill {
            
            chosenFillColor = cell?.backgroundColor ?? UIColor.redColor()
            fsButton.innerColor = chosenFillColor
            
        } else {
            
            chosenStrokeColor = cell?.backgroundColor ?? UIColor.blackColor()
            fsButton.outerColor = chosenStrokeColor
            
        }
        //redraws the object in the drawRect
        fsButton.setNeedsDisplay()
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            switch chosenTool {
                // Scribble
            case 1 :
                
                let newScribble = Scribble()
                
                newScribble.points.append(touch.locationInView(view))
                
                newScribble.strokeColor = chosenStrokeColor
                newScribble.fillColor = chosenFillColor
                newScribble.strokeWidth = strokeWidth
                
                (view as? DrawView)?.lines.append(newScribble)
                
                
            case 2 :
                startShape(.Circle, withTouch: touch)
                
                
            case 3 :
                startShape(.Rectangle, withTouch: touch)
                
                
            case 4 :
                startShape(.Triangle, withTouch: touch)
                
                
            case 5 :
                startShape(.Diamond, withTouch: touch)
                
                //Line
            default :
                
                let newLine = Line()
                
                
                //let locPoint = touch.locationInView(view)
                
                newLine.start = touch.locationInView(view)
                
                newLine.strokeColor = chosenStrokeColor
                newLine.fillColor = chosenFillColor
                newLine.strokeWidth = strokeWidth
                
                
                //look at View as DrawView if not, then will not crash
                (view as? DrawView)?.lines.append(newLine)
                
            }
            
            view.setNeedsDisplay()
        }
    }
    
    func startShape(type: ShapeType, withTouch touch: UITouch) {
        
        //SHAPE)
        
        // initializing shape
        let shape = Shape(type: type)
        // sets start location of the shape (top left corner of the shape)
        shape.start = touch.locationInView(view)
        // sets color of the shape
        shape.strokeColor = chosenStrokeColor
        shape.fillColor = chosenFillColor
        shape.strokeWidth = strokeWidth
        
        
        (view as? DrawView)?.lines.append(shape)
        
        
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            
            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
                
                currentScribble.points.append(touch.locationInView(view))
                
                view.setNeedsDisplay()
                
            } else if let currentLine = (view as? DrawView)?.lines.last {
                
                currentLine.end = touch.locationInView(view)
                
                view.setNeedsDisplay()
            }
            
        }
    }
}

class Colors: NSObject, UICollectionViewDataSource {
    
    let fillColors = [
        
        UIColor.greenColor(),
        UIColor.blueColor(),
        UIColor.redColor(),
        UIColor.blackColor(),
        UIColor.purpleColor(),
        UIColor.cyanColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.whiteColor(),
        UIColor(red:0.36, green:0.01, blue:0, alpha:1),
        UIColor(red:0.96, green:0.96, blue:0.86, alpha:1),
        UIColor(red:1, green:0.41, blue:0, alpha:1),
        UIColor(red:0.22, green:1, blue:0.08, alpha:1),
        UIColor(red:0.87, green:1, blue:0.33, alpha:1),
        UIColor.clearColor()
        
    ]
    
    let strokeColors = [
        
        UIColor(red:0.36, green:0.01, blue:0, alpha:1),
        UIColor(red:0.96, green:0.96, blue:0.86, alpha:1),
        UIColor(red:1, green:0.41, blue:0, alpha:1),
        UIColor(red:0.22, green:1, blue:0.08, alpha:1),
        UIColor(red:0.87, green:1, blue:0.33, alpha:1),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.whiteColor(),
        UIColor.greenColor(),
        UIColor.blueColor(),
        UIColor.redColor(),
        UIColor.blackColor(),
        UIColor.purpleColor(),
        UIColor.cyanColor(),
        UIColor(red:0.96, green:0.73, blue:0.81, alpha:1)
        
    ]
    
    // bulean whether its filled or stroked
    var isFill = true
    
    // ask for data for collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // if it is stroke color use database 1, if fill then database 2
        return isFill ? fillColors.count : strokeColors.count
        
        
    }
    // runs however many items are stated in the return on previous code of set colors.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath)
        
        cell.backgroundColor = isFill ? fillColors[indexPath.item] : strokeColors[indexPath.item]
        
        
        return cell
    }
    
}





