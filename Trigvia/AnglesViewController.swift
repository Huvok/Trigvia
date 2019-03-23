//
//  AnglesViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class AnglesViewController: UIViewController {

    
    @IBOutlet weak var tfAngle1: UITextField!
    @IBOutlet weak var tfAngle2: UITextField!
    @IBOutlet weak var tfAngle3: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sidesView = segue.destination as! SidesViewController
        
        if let angle1 = Float(tfAngle1.text!){
            sidesView.fAngle1 = angle1
            
        }
        if let angle2 = Float(tfAngle2.text!){
            sidesView.fAngle2 = angle2
        }
        if let angle3 = Float(tfAngle3.text!){
            sidesView.fAngle3 = angle3
        }
    }

}
