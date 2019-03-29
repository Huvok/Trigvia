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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        x1 = 60.0
        y1 = 60.0
        x2 = dSide1 + 60
        y2 = y1
        x3 = cos(dAngle2 / 360 * 2 * Double.pi) * dSide2
        y3 = sin(dAngle2 / 360 * 2 * Double.pi) * dSide2
        drawTriangle()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let error = 10.0
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
    
    func drawTriangle() {
        
        bezierView = BezierView(frame: bezierView.frame)
        bezierView.setCoordinates(_x1: x1, _y1: y1,
                                  _x2: x2, _y2: y2,
                                  _x3: x3, _y3: y3)
        self.view.addSubview(bezierView)
        
        let sidea = sqrt(abs(x2 - x3) + abs(y2 - y3))
        let sideb = sqrt(abs(x3 - x1) + abs(y3 - y1))
        let sidec = sqrt(abs(x1 - x2) + abs(y1 - y2))
        lba.text! = "a = " + String(format:"%.4f", sidea)
        lbb.text! = "b = " + String(format:"%.4f", sideb)
        lbc.text! = "c = " + String(format:"%.4f", sidec)
        
        let angleC = acos((sidea * sidea + sideb * sideb - sidec * sidec) / (-2.0 * sidea * sideb))
        let angleB = acos((sidec * sidec + sidea * sidea - sideb * sideb) / (-2.0 * sidea * sidec))
        let angleA = acos((sideb * sideb + sidec * sidec - sidea * sidea) / (-2.0 * sideb * sidec))
        lbA.text! = "A = " + String(format:"%.4f", angleA * 180 / Double.pi)
        lbB.text! = "B = " + String(format:"%.4f", angleB * 180 / Double.pi)
        lbC.text! = "C = " + String(format:"%.4f", angleC * 180 / Double.pi)
    }
}
