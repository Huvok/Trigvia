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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        drawTriangle()
    }
    
    func drawTriangle() {
        let width: CGFloat = 240.0
        let height: CGFloat = 160.0
        
        let bezierView = BezierView(frame: CGRect(x: self.view.frame.size.width / 2 - width / 2,
                                                  y: self.view.frame.size.height / 2 - height / 2,
                                                  width: width,
                                                  height: height))
        
        let x1 = 0.0
        let y1 = 60.0
        let x2 = dSide1
        let y2 = y1
        let x3 = cos(dAngle2 / 360 * 2 * Double.pi) * dSide2
        let y3 = sin(dAngle2 / 360 * 2 * Double.pi) * dSide2
        
        bezierView.setCoordinates(_x1: x1, _y1: y1,
                                  _x2: x2, _y2: y2,
                                  _x3: x3, _y3: y3)
        self.view.addSubview(bezierView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
