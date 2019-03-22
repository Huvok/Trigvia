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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let fSide1 = Float(tfSide1.text!),
            let fSide2 = Float(tfSide2.text!),
            let fSide3 = Float(tfSide3.text!) {
            
            if fSide1 <= 0 ||
                fSide2 <= 0 ||
                fSide3 <= 0  {
                let alert = UIAlertController(title: "Error", message: "Los datos proporcionados no son válidos", preferredStyle: .alert)
                let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(accion)
                present(alert, animated: true, completion: nil)
            }
            else {
                let vistaPlayground = segue.destination as! PlaygroundViewController
                vistaPlayground.intMode = 2
                vistaPlayground.fSide1 = fSide1
                vistaPlayground.fSide2 = fSide2
                vistaPlayground.fSide3 = fSide3
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
