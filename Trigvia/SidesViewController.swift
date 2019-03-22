//
//  SidesViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class SidesViewController: UIViewController {

    @IBOutlet var tfSides: [UITextField]!
    
    var angles = [Double?]()
    var sides = [Double?]()
    
    let ERROR_MESSAGES = ["",
                          "",
                          "Todos los valores tienen que ser positivos",
                          "Alguno de los valores introducidos no es un número"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Data methods
    func solveRemainingAngle() {
        var remVal = 180.0
        for i in 0...2 {
            if angles[i] != nil {
                remVal -= angles[i]!
            }
        }
        for i in 0...2 {
            if angles[i] == nil {
                angles[i] = remVal
            }
        }
    }
    
    func countProvidedMeasures(arr: [Double?]) -> Int {
        var ans = 0
        for i in 0...2 {
            if arr[i] != nil {
                ans = ans + 1
            }
        }
        return ans
    }
    
    func findFirstProvided(arr: [Double?]) -> Int {
        for i in 0...2 {
            if arr[i] != nil {
                return i
            }
        }
        return -1
    }
    
    func validateLawOfSines() -> Bool {
        var ratio: Double? = nil
        for i in 0...2 {
            if angles[i] != nil && sides[i] != nil {
                if ratio != nil {
                    if ratio != sin(angles[i]! / 180.0 * Double.pi) / sides[i]! {
                        return false
                    }
                }
                else{
                    ratio = sin(angles[i]! / 180.0 * Double.pi) / sides[i]!
                }
            }
        }
        return true
    }
    
    func validateTriangleInequality() -> Bool {
        for i in 0...2 {
            if sides[i]! + sides[ (i + 1) % 3 ]! <= sides[ (i + 2) % 3 ]! {
                return false
            }
        }
        return true
    }
    
    func validateInput() -> Bool{
        var sidesProvided = countProvidedMeasures(arr: sides)
        for i in 0...2 {
            let side_str = tfSides[i].text
            if !side_str!.trimmingCharacters(in: .whitespaces).isEmpty{
                // try to make it a number
                if let side = Double(side_str!) {
                    if side <= 0.0 {
                        showAlert(message: ERROR_MESSAGES[2])
                        return false
                    }
                    sides[i] = side
                }
                else{
                    showAlert(message: ERROR_MESSAGES[3])
                    return false
                }
            }
            else { angles[i] = nil }
        }
        // Validate depending on the amount of sides
        let anglesProvided = countProvidedMeasures(arr: angles)
        switch anglesProvided {
        case 0:
            // must provide every side
            if sidesProvided == 3 {
                if !validateTriangleInequality() {
                    // ERROR_MESSAGE: This is not a valid triangle
                    return false
                }
            }
            else{
                // ERROR_MESSAGE: Must provide ALL 3 sides if no angle is provided
                return false
            }
        case 1:
            // must provide at least 2 sides
            if sidesProvided <= 1 {
                // ERROR_MESSAGE: Must provide at least 2 sides
                return false
            }
            else{
                // This is the ugliest case
            }
        default:
            if anglesProvided == 2 {
                solveRemainingAngle() // now we have ALL 3 angles
            }
            if !validateLawOfSines() {
                // ERROR_MESSAGE: Invalid Measures
                return false
            }
        }
        return true
    }
    
    func solveMeasures() {
        // once we have valid measures of the triangle, we calculate the
        // rest of them
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
        let playgroundView = segue.destination as! PlaygroundViewController
        
    }

}
