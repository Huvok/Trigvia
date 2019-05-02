//
//  PlaygroundViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {
    
    var dAngle1 : Double = 60*Double.pi/180
    var dAngle2 : Double = 60*Double.pi/180
    var dAngle3 : Double = 60*Double.pi/180
    var dSide1 : Double = 10
    var dSide2 : Double = 10
    var dSide3 : Double = 10
    
    var x1: Double = 0.0
    var y1: Double = 0.0
    var x2: Double = 0.0
    var y2: Double = 0.0
    var x3: Double = 0.0
    var y3: Double = 0.0
    
    var width : Double = 0.0
    var height : Double = 0.0
    
    @IBOutlet var bezierView: BezierView!
    @IBOutlet weak var lbA: UILabel!
    @IBOutlet weak var lbB: UILabel!
    @IBOutlet weak var lbC: UILabel!
    @IBOutlet weak var lba: UILabel!
    @IBOutlet weak var lbb: UILabel!
    @IBOutlet weak var lbc: UILabel!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var returnBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData.layer.cornerRadius = 8
        viewData.clipsToBounds = true
        returnBtn.layer.cornerRadius = 8

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dSide1 *= 100
        dSide2 *= 100
        dSide3 *= 100
        width = Double(bezierView.bounds.width)
        height = Double(bezierView.bounds.height)
        if (dAngle2 > Double.pi/2){
            x1 = -dSide3*sin(dAngle2 - Double.pi/2)
            y1 = -dSide3*sin(Double.pi - dAngle2)
        }else if (dAngle2 < Double.pi/2){
            if (dAngle3 > Double.pi/2){
                x1 = dSide1 + dSide2*sin(dAngle3 - Double.pi/2)
                y1 = -dSide2*sin(Double.pi - dAngle3)
            }else if (dAngle3 < Double.pi/2){
                x1 = dSide3*sin(dAngle1/2)
                y1 = -dSide3*sin(dAngle2)
            } else {
                x1 = dSide1
                y1 = -dSide2
            }
        }else{
            x1 = 0
            y1 = -dSide3
        }
        x2 = 0
        y2 = 0
        x3 = dSide1
        y3 = 0
        let centroid_x = (x1 + x3)/3
        let centroid_y = y1/3
        x1 -= centroid_x
        x2 -= centroid_x
        x3 -= centroid_x
        y1 -= centroid_y
        y2 -= centroid_y
        y3 -= centroid_y
        let bounding_x = max(x1, x2, x3) - min(x1, x2 , x3)
        let bounding_y = max(y1, y2, y3) - min(y1, y2 , y3)
        var scale_factor = 1.0
        if (bounding_x > width - 100 && bounding_y > height - 100){
            if bounding_x > bounding_y {
                scale_factor = (width - 100) / bounding_x
            }
            else{
                scale_factor = (height - 100) /  bounding_y
            }
        }
        else if (bounding_x > width - 100){
            scale_factor = (width - 100) / bounding_x
        }
        else{
            scale_factor = (height - 100) / bounding_y
        }
        x1 = x1 * scale_factor
        x2 = x2 * scale_factor
        x3 = x3 * scale_factor
        y1 = y1 * scale_factor
        y2 = y2 * scale_factor
        y3 = y3 * scale_factor
        let diffx = (width - (max(x1, x2, x3) - min(x1, x2 , x3)))/2 - min(x1, x2 , x3)
        let diffy = (width - (max(y1, y2, y3) - min(y1, y2 , y3)))/2 - min(y1, y2 , y3)
        x1 += diffx
        x2 += diffx
        x3 += diffx
        y1 += diffy
        y2 += diffy
        y3 += diffy
        print(x1, x3)
        drawTriangle()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let error = 24.0
        let dist = 15.0
        let touch = touches.first!
        let location = touch.location(in: bezierView)
        let hitView = bezierView.hitTest(location, with: event)
        if (bezierView == hitView) {
            let yFinal = Double(location.y)
            let xFinal = Double(location.x)
            if (xFinal > dist && xFinal < width - dist &&
                yFinal > dist && yFinal < height - dist){
                let dist1 = hypot(x1 - xFinal, y1 - yFinal)
                let dist2 = hypot(x2 - xFinal, y2 - yFinal)
                let dist3 = hypot(x3 - xFinal, y3 - yFinal)
                if dist1 < error {
                    x1 = xFinal
                    y1 = yFinal
                    drawTriangle()
                }
                else if dist2 < error {
                    x2 = xFinal
                    y2 = yFinal
                    drawTriangle()
                }
                else if dist3 < error {
                    x3 = xFinal
                    y3 = yFinal
                    drawTriangle()
                }
            }
        }
    }
    
    func euclidean(x1 : Double, y1: Double, x2: Double, y2: Double) -> Double{
        let diffX = (x1 - x2)*(x1 - x2)
        let diffY = (y1 - y2)*(y1 - y2)
        return sqrt(diffX + diffY)
    }
    func drawTriangle() {
        
        bezierView = BezierView(frame: bezierView.frame)
        bezierView.setCoordinates(_x1: x1, _y1: y1,
                                  _x2: x2, _y2: y2,
                                  _x3: x3, _y3: y3)
        self.view.addSubview(bezierView)
        
        
        //let sidea = sqrt((x2 - x3)*(x2 - x3) + (y2 - y3)*(y2 - y3))
        let sidea = Double(round(5*euclidean(x1 : x2, y1: y2, x2: x3, y2: y3))/100)
        //let sideb = sqrt((x3 - x1)*(x3 - x1) + (y3 - y1)*(y3 - y1))
        let sideb = Double(round(5*euclidean(x1 : x3, y1: y3, x2: x1, y2: y1))/100)
        //let sidec = sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2))
        let sidec = Double(round(5*euclidean(x1 : x1, y1: y1, x2: x2, y2: y2))/100)
        
        lba.text! = String(format:"%.2f", sidea)
        lbb.text! = String(format:"%.2f", sideb)
        lbc.text! = String(format:"%.2f", sidec)
        
        let angleC = acos((sidea * sidea + sideb * sideb - sidec * sidec) / (2.0 * sidea * sideb))
        let angleB = acos((sidea * sidea + sidec * sidec - sideb * sideb) / (2.0 * sidea * sidec))
        let angleA = acos((sidec * sidec + sideb * sideb - sidea * sidea) / (2.0 * sidec * sideb))
        lbA.text! = String(format:"%.2f", angleA * 180 / Double.pi)
        lbB.text! = String(format:"%.2f", angleB * 180 / Double.pi)
        lbC.text! = String(format:"%.2f", angleC * 180 / Double.pi)
    }
}
