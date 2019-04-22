//
//  PlaygroundViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {
    
    var dAngle1 : Double = 0.0
    var dAngle2 : Double = 60.0
    var dAngle3 : Double = 60.0
    var dSide1 : Double = 30.0
    var dSide2 : Double = 40.0
    var dSide3 : Double = 50.0
    
    var x1: Double!
    var y1: Double!
    var x2: Double!
    var y2: Double!
    var x3: Double!
    var y3: Double!
    
    @IBOutlet var bezierView: BezierView!
    @IBOutlet weak var lbA: UILabel!
    @IBOutlet weak var lbB: UILabel!
    @IBOutlet weak var lbC: UILabel!
    @IBOutlet weak var lba: UILabel!
    @IBOutlet weak var lbb: UILabel!
    @IBOutlet weak var lbc: UILabel!
    @IBOutlet weak var viewData: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData.layer.cornerRadius = 8
        viewData.clipsToBounds = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        x1 = 60.0
        y1 = 60.0
        x2 = dSide1 + 60
        y2 = y1
        x3 = cos(dAngle2 / 360 * 2 * Double.pi) * dSide2
        y3 = sin(dAngle2 / 360 * 2 * Double.pi) * dSide2
        let width = Double(bezierView.bounds.width/2)
        let height = Double(bezierView.bounds.width/2)
        x1 = x1 + width
        y1 = y1 + height
        x2 = x2 + width
        y2 = y2 + height
        x3 = x3 + width
        y3 = y3 + height
        drawTriangle()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let error = 24.0
        let touch = touches.first!
        let location = touch.location(in: bezierView)
        let hitView = bezierView.hitTest(location, with: event)
        if (bezierView == hitView) {
            let yFinal = Double(location.y)
            let xFinal = Double(location.x)
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
        let sideb = Double(round(5*euclidean(x1 : x1, y1: y1, x2: x3, y2: y3))/100)
        //let sidec = sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2))
        let sidec = Double(round(5*euclidean(x1 : x1, y1: y1, x2: x2, y2: y2))/100)
        
        lba.text! = String(format:"%.2f", sidea)
        lbb.text! = String(format:"%.2f", sideb)
        lbc.text! = String(format:"%.2f", sidec)
        
        let angleC = acos((sidea * sidea + sideb * sideb - sidec * sidec) / (2.0 * sidea * sideb))
        let angleB = asin(sideb * sin(angleC)/sidec)
        let angleA = asin(sidea * sin(angleC)/sidec)
        lbA.text! = String(format:"%.4f", angleA * 180 / Double.pi)
        lbB.text! = String(format:"%.4f", angleB * 180 / Double.pi)
        lbC.text! = String(format:"%.4f", angleC * 180 / Double.pi)
    }
}
