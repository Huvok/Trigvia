//
//  BezierView.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class BezierView: UIView {

    var path : UIBezierPath!
    var x1 : Double = 0.0
    var y1 : Double = 0.0
    var x2 : Double = 0.0
    var y2 : Double = 0.0
    var x3 : Double = 0.0
    var y3 : Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        //    self.createRectangle()
        self.createTriangle()
        
        // Specify a border (stroke) color.
        UIColor.black.setStroke()
        path.stroke()
    }
    
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        path.addLine(to: CGPoint(x: x3, y: y3))
        path.close()
    }

    func setCoordinates(_x1: Double, _y1: Double,
                        _x2: Double, _y2: Double,
                        _x3: Double, _y3: Double) {
        x1 = _x1
        y1 = _y1
        x2 = _x2
        y2 = _y2
        x3 = _x3
        y3 = _y3
    }
}
