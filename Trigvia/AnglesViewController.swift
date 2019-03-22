//
//  AnglesViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class AnglesViewController: UIViewController {

    @IBOutlet var tfAngles: [UITextField]!
    var angles = [Double?](repeating: nil, count: 3)
    
    let ERROR_MESSAGES = ["Si introduces 3 ángulos, deben sumar exactamente 180",
                          "La suma de los ángulos que has introducido excede 180",
                          "Todos los valores tienen que ser positivos",
                          "Alguno de los valores introducidos no es un número"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Data methods
    
    func validateInput() -> Bool{
        var sumOfAngles = 0.0
        var anglesProvided = 0
        for i in 0...2 {
            let angle_str = tfAngles[i].text
            if !angle_str!.trimmingCharacters(in: .whitespaces).isEmpty{
                // try to make it a number
                if let angle = Double(angle_str!) {
                    if angle <= 0.0 {
                        showAlert(message: ERROR_MESSAGES[2])
                        return false
                    }
                    angles[i] = angle
                    sumOfAngles += angle
                    anglesProvided = anglesProvided + 1
                }
                else{
                    showAlert(message: ERROR_MESSAGES[3])
                    return false
                }
            }
            else { angles[i] = nil }
        }
        if anglesProvided == 3 {
            if sumOfAngles != 180.0 {
                showAlert(message: ERROR_MESSAGES[0])
                return false
            }
        }
        else{
            if sumOfAngles >= 180.0 {
                showAlert(message: ERROR_MESSAGES[1])
                return false
            }
        }
        return true
    }
    
    // MARK: - Alert methods
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Valores Incorrectos", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation methods
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return validateInput()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sidesView = segue.destination as! SidesViewController
        sidesView.angles = angles
    }
}
