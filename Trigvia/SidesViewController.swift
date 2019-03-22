//
//  SidesViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class SidesViewController: UIViewController {

    
    @IBOutlet weak var tfSide1: UITextField!
    @IBOutlet weak var tfSide2: UITextField!
    @IBOutlet weak var tfSide3: UITextField!
    
    var fAngle1 : Float = 0.0
    var fAngle2 : Float = 0.0
    var fAngle3 : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playgroundView = segue.destination as! PlaygroundViewController
        
    }

}
