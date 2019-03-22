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
        if let intAngle1 = Int(tfAngle1.text!),
            let intAngle2 = Int(tfAngle2.text!),
            let intAngle3 = Int(tfAngle3.text!) {
            
            if intAngle1 >= 180 || intAngle1 <= 0 ||
                intAngle2 >= 180 || intAngle2 <= 0 ||
                intAngle3 >= 180 || intAngle3 <= 0 ||
                intAngle1 + intAngle2 + intAngle3 != 180 {
                let alert = UIAlertController(title: "Error", message: "Los datos proporcionados no son válidos", preferredStyle: .alert)
                let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(accion)
                present(alert, animated: true, completion: nil)
            }
            else {
                let vistaPlayground = segue.destination as! PlaygroundViewController
                vistaPlayground.intModo = 1
                vistaPlayground.intAngle1 = intAngle1
                vistaPlayground.intAngle2 = intAngle2
                vistaPlayground.intAngle3 = intAngle3
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Los campos deben tener valor", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(accion)
            present(alert, animated: true, completion: nil)
        }
    }

}
