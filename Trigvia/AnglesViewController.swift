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
        if let fAngle1 = Float(tfAngle1.text!),
            let fAngle2 = Float(tfAngle2.text!),
            let fAngle3 = Float(tfAngle3.text!) {
            
            if fAngle1 >= 180.0 || fAngle1 <= 0.0 ||
                fAngle2 >= 180.0 || fAngle2 <= 0.0 ||
                fAngle3 >= 180.0 || fAngle3 <= 0.0 ||
                fAngle1 + fAngle2 + fAngle3 != 180.0 {
                let alert = UIAlertController(title: "Error", message: "Los datos proporcionados no son válidos", preferredStyle: .alert)
                let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(accion)
                present(alert, animated: true, completion: nil)
            }
            else {
                let vistaPlayground = segue.destination as! PlaygroundViewController
                vistaPlayground.intMode = 1
                vistaPlayground.fAngle1 = fAngle1
                vistaPlayground.fAngle2 = fAngle2
                vistaPlayground.fAngle3 = fAngle3
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
