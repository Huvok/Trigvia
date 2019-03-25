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
    var sides = [Double?](repeating: nil, count: 3)
    
    let ERROR_MESSAGES = ["Las medidas de los lados introducidos no cumplen la desigualdad del triángulo",
                          "Si ninguna medida de un ángulo ha sido introducida, se deben dar medidas para todos los lados",
                          "Todos los valores tienen que ser positivos",
                          "Alguno de los valores introducidos no es un número",
                          "Si sólo has introducido un ángulo, debes introducir al menos 2 lados",
                          "No se pudo construir un triángulo con las medidas proporcionadas",
                          "Medidas de triángulo inválido, te recomendamos introducir la medida de exactamente un lado"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Auxiliar methods
    
    func degreesToRadians(degrees: Double) -> Double {
        var radians = degrees / 180.0 * Double.pi
        return radians
    }
    
    func radiansToDegrees(radians: Double) -> Double {
        var degrees = radians / Double.pi * 180.0
        return degrees
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
    
    // MARK: - Iterations to solve
    
    func iterateSumOfAngles() {
        if countProvidedMeasures(arr: angles) != 2 { return }
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
    
    func iterateLawOfSines(){
        var ratio: Double? = nil
        // get the ratio
        for i in 0...2 {
            if angles[i] != nil && sides[i] != nil {
                ratio = sin(degreesToRadians(degrees: angles[i]!)) / sides[i]!
            }
        }
        // solve as much as you can
        for i in 0...2 {
            if ratio != nil && sides[i] != nil && angles[i] == nil {
                angles[i] = radiansToDegrees(radians: asin(ratio! * sides[i]!))
            }
            else if ratio != nil && sides[i] == nil && angles[i] != nil {
                sides[i] = sin(degreesToRadians(degrees: angles[i]!)) / ratio!
            }
        }
    }
    
    func iterateLawOfCosines() {
        if !(countProvidedMeasures(arr: angles) == 1 && countProvidedMeasures(arr: sides) == 2) { return }
        let i = findFirstProvided(arr: angles)
        if sides[(i + 1) % 3] != nil && sides[(i + 2) % 3] != nil {
            // use the law of sines to calc sides[i]
            sides[i] = sides[(i + 1) % 3]! * sides[(i + 1) % 3]! +
                        sides[(i + 2) % 3]! * sides[(i + 2) % 3]! -
                        2 * sides[(i + 1) % 3]! * sides[(i + 2) % 3]! * cos(degreesToRadians(degrees: angles[i]!))
            sides[i] = sides[i]!.squareRoot()
        }
    }
    
    // MARK: - Validation methods
    
    func validateSumOfAngles() -> Bool {
        var sum = 0.0
        for i in 0...2 {
            if angles[i] == nil { return false }
            sum = sum + angles[i]!
        }
        return (sum == 180.0)
    }
    
    func validateLawOfSines() -> Bool {
        var ratio: Double? = nil
        for i in 0...2 {
            if angles[i] != nil && sides[i] != nil {
                if ratio != nil {
                    if ratio != sin(degreesToRadians(degrees: angles[i]!)) / sides[i]! {
                        return false
                    }
                }
                else{
                    ratio = sin(degreesToRadians(degrees: angles[i]!)) / sides[i]!
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
            else { sides[i] = nil }
        }
        
        // Validate depending on the amount of sides
        iterateSumOfAngles()
        let anglesProvided = countProvidedMeasures(arr: angles)
        let sidesProvided = countProvidedMeasures(arr: sides)
        switch anglesProvided {
        case 0:
            // must provide every side
            if sidesProvided == 3 {
                if !validateTriangleInequality() {
                    showAlert(message: ERROR_MESSAGES[0])
                    return false
                }
            }
            else{
                showAlert(message: ERROR_MESSAGES[1])
                return false
            }
        case 1:
            // must provide at least 2 sides
            if sidesProvided <= 1 {
                showAlert(message: ERROR_MESSAGES[4])
                return false
            }
            else{
                iterateLawOfSines()
                iterateLawOfSines()
                iterateSumOfAngles()
                iterateLawOfSines()
                if !validateSumOfAngles() {
                    showAlert(message: ERROR_MESSAGES[5])
                    return false
                }
            }
        default:
            if !validateLawOfSines() {
                showAlert(message: ERROR_MESSAGES[6])
                return false
            }
        }
        showAlert(message: "Success!!!")
        return true
    }
    
    func solveMeasures() {
        // check special case on the law of cosines
        iterateLawOfCosines()
        // solve the rest with the law of sines
        iterateLawOfSines()
        iterateLawOfSines()
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
        solveMeasures()
        let playgroundView = segue.destination as! PlaygroundViewController
        
        for i in 0...2 {
            print(angles[i]!)
        }
        for i in 0...2 {
            print(sides[i]!)
        }
    }

}
