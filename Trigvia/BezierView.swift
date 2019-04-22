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
        UIColor.black.setStroke()
        path.lineWidth = 3.0
        path.stroke()
    }
    
    func createTriangle() {
        path = UIBezierPath()
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        path.addLine(to: CGPoint(x: x3, y: y3))
        path.close()
        createTextLayer()
    }
    
    func drawLetter(letter: String, x: Double, y: Double){
        let n = 24.0
        let textLayer = CATextLayer()
        textLayer.string = letter
        textLayer.foregroundColor = UIColor.red.cgColor
        textLayer.font = UIFont(name: "Avenir", size: CGFloat(n) )
        textLayer.fontSize = CGFloat(n)
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        //textLayer.backgroundColor = UIColor.blue.cgColor
        //textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.frame = CGRect(x: x - n/2, y: y - n/2, width: n, height: n)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
    }
    
    func createTextLayer() {
        drawLetter(letter: "A", x: x1, y: y1)
        drawLetter(letter: "B", x: x2, y: y2)
        drawLetter(letter: "C", x: x3, y: y3)
        drawLetter(letter: "a", x: (x2 + x3) / 2, y: (y2 + y3) / 2)
        drawLetter(letter: "b", x: (x3 + x1) / 2, y: (y3 + y1) / 2)
        drawLetter(letter: "c", x: (x1 + x2) / 2, y: (y1 + y2) / 2)
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
