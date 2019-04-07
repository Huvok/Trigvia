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
        path.stroke()
    }
    
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        path.addLine(to: CGPoint(x: x3, y: y3))
        path.close()
        
        createTextLayer()
    }
    
    func createTextLayer() {
        var textLayer = CATextLayer()
        textLayer.string = "A"
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 10.0)
        textLayer.fontSize = 10.0
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: x1, y: y1, width: 10, height: 10)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
        textLayer = CATextLayer()
        textLayer.string = "B"
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 10.0)
        textLayer.fontSize = 10.0
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: x2, y: y2, width: 10, height: 10)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
        textLayer = CATextLayer()
        textLayer.string = "C"
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 10.0)
        textLayer.fontSize = 10.0
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: x3, y: y3, width: 10, height: 10)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
        textLayer = CATextLayer()
        textLayer.string = "a"
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 10.0)
        textLayer.fontSize = 10.0
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: (x2 + x3) / 2, y: (y2 + y3) / 2, width: 10, height: 10)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
        textLayer = CATextLayer()
        textLayer.string = "b"
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 10.0)
        textLayer.fontSize = 10.0
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: (x3 + x1) / 2, y: (y3 + y1) / 2, width: 10, height: 10)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
        textLayer = CATextLayer()
        textLayer.string = "c"
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 10.0)
        textLayer.fontSize = 10.0
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: (x1 + x2) / 2, y: (y1 + y2) / 2, width: 10, height: 10)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
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
