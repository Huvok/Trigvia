//
//  SidesViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit
import iosMath

class SidesViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate  {

    @IBOutlet var tfSides: [UITextField]!
    @IBOutlet var tfAngles: [UITextField]!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSolve: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnReturn: UIButton!
    
    var activeField : UITextField!
    
    var angles = [Double?](repeating: nil, count: 3)
    var sides = [Double?](repeating: nil, count: 3)
    
    var solutionSteps = [String]()
    
    var anglesNames = ["\\alpha", "\\beta", "\\theta"]
    var sideNames = ["a", "b", "c"]
    var lines = 0
    
    let MAX_ERROR_MARGIN = 0.000001
    
    let ERROR_MESSAGES = ["Alguno de los valores introducidos no es un número",
                          "Alguno de los valores está fuera del rango permitido",
                          "No se pudo construir un triángulo con las medidas proporcionadas"]
    
    let ERROR_MESSAGES_ANGLES = ["Si introduces 3 ángulos, deben sumar exactamente 180",
                                 "La suma de menos de 3 ángulos, deben ser menor 180"]
    
    let ERROR_MESSAGES_SIDES = ["Las medidas de los lados introducidos no cumplen la desigualdad del triángulo",
                                "Si ninguna medida de un ángulo ha sido introducida, se deben dar medidas para todos los lados",
                                "Si sólo has introducido un ángulo, debes introducir al menos 2 lados"]
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        btnReturn.layer.cornerRadius = 8
        btnSolve.layer.cornerRadius = 8
        tfSides[0].delegate = self
        tfSides[1].delegate = self
        tfSides[2].delegate = self
        tfAngles[0].delegate = self
        tfAngles[1].delegate = self
        tfAngles[2].delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        self.view.addGestureRecognizer(tap)
        self.registrarseParaNotificacionesDeTeclado()
    }
    
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    func registrarseParaNotificacionesDeTeclado() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(aNotification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(aNotification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func keyboardWasShown(aNotification : NSNotification) {
        
        let kbSize = (aNotification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = scrollView.frame
        aRect.size.height -= kbSize.height
        if !aRect.contains(activeField.frame.origin) {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    @IBAction func keyboardWillBeHidden(aNotification : NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    
    func clearData() {
        angles = [Double?](repeating: nil, count: 3)
        sides = [Double?](repeating: nil, count: 3)
        solutionSteps = [String]()
        lines = 0
    }
    
    func numToStr(num: Double?) -> String {
        return String(format: "%.2f", num!)
    }
    
    func addCurrentMeasuresToSolutionSteps() {
        if countProvidedMeasures(arr: angles) > 0 || countProvidedMeasures(arr: sides) > 0 {
            solutionSteps.append("\\text{Tenemos que:} \\\\")
            lines = lines + 1
            for i in 0...2 {
                if angles[i] != nil {
                    solutionSteps.append("\(anglesNames[i])=\(numToStr(num: angles[i]))^{o}\\\\")
                    lines = lines + 1
                }
            }
            for i in 0...2 {
                if sides[i] != nil {
                    solutionSteps.append("\(sideNames[i])=\(numToStr(num: sides[i]))\\\\")
                    lines = lines + 1
                }
            }
        }
    }
    
    func closeCompare(numA: Double, numB: Double) -> Bool {
        return fabs(numA - numB) < MAX_ERROR_MARGIN
    }
    
    // MARK: - Auxiliar methods
    
    func degreesToRadians(degrees: Double) -> Double {
        let radians = degrees / 180.0 * Double.pi
        return radians
    }
    
    func radiansToDegrees(radians: Double) -> Double {
        let degrees = radians / Double.pi * 180.0
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
                solutionSteps.append("\\text{Por suma de \'{a}ngulos internos en}\\\\ \\text{un tri\'{a}ngulo, obtenemos que}\\\\ \(anglesNames[i]) = 180^{o} - \(anglesNames[(i+1)%3]) - \(anglesNames[(i+2)%3]) = \(numToStr(num: remVal))^{o}\\\\ ")
                lines = lines + 3
            }
        }
    }
    
    func iterateLawOfSines(){
        var ratio: Double? = nil
        // get the ratio
        var idxOfRatio = 0
        for i in 0...2 {
            if angles[i] != nil && sides[i] != nil {
                ratio = sin(degreesToRadians(degrees: angles[i]!)) / sides[i]!
                idxOfRatio = i
            }
        }
        // solve as much as you can
        for i in 0...2 {
            if ratio != nil && sides[i] != nil && angles[i] == nil {
                if sides[0] != nil && sides[1] != nil && sides[2] != nil{
                    if i == 0 {
                        // A = acos((c^2 + b^2 - a^2)/ 2cb)
                        let num = pow(sides[2]!, 2) + pow(sides[1]!, 2) - pow(sides[0]!, 2)
                        angles[0] = acos(num / (2.0 * sides[2]! * sides[1]!))
                    }else if i == 1{
                        // let angleB = acos((sidea * sidea + sidec * sidec - sideb * sideb) / (2.0 * sidea * sidec))
                        let num = pow(sides[0]!, 2) + pow(sides[2]!, 2) - pow(sides[1]!, 2)
                        angles[1] = acos(num / (2.0 * sides[0]! * sides[2]!))
                    }else{
                        // C = acos((a^2 + b^2 - c^2)/2ab)
                        let num = pow(sides[0]!, 2) + pow(sides[1]!, 2) - pow(sides[2]!, 2)
                        angles[2] = acos(num / (2.0 * sides[0]! * sides[1]!))
                    }
                    angles[i] = radiansToDegrees(radians: angles[i]!)
                }else{
                    angles[i] = radiansToDegrees(radians: asin(ratio! * sides[i]!))
                }
                solutionSteps.append("\\text{Por ley de senos,}\\\\ \\frac{sin(\(anglesNames[i]))}{\(sideNames[i])}= \\frac{sin(\(anglesNames[idxOfRatio]))}{\(sideNames[idxOfRatio])}=\(numToStr(num: ratio))\\\\ ")
                lines = lines + 2
                solutionSteps.append("\\text{Entonces}\\\\ \(anglesNames[i])=sin^{-1}(\(numToStr(num: ratio)) \\cdot \(sideNames[i]))=\(numToStr(num: angles[i]))^{o}\\\\ ")
                lines = lines + 2
            }
            else if ratio != nil && sides[i] == nil && angles[i] != nil {
                sides[i] = sin(degreesToRadians(degrees: angles[i]!)) / ratio!
                solutionSteps.append("\\text{Por ley de senos,}\\\\ \\frac{sin(\(anglesNames[i]))}{\(sideNames[i])} = \\frac{sin(\(anglesNames[idxOfRatio]))}{\(sideNames[idxOfRatio])}=\(numToStr(num: ratio))\\\\ ")
                lines = lines + 2
                solutionSteps.append("\\text{Entonces}\\\\ \(sideNames[i])=\\frac{sin(\(anglesNames[i]))}{\(String(format: "%.4f", ratio!))}=\(numToStr(num: sides[i]))\\\\ ")
                lines = lines + 2
            }
        }
    }
    
    func iterateLawOfCosines() {
        // solve missing angles
        if countProvidedMeasures(arr: sides) == 3 {
            if countProvidedMeasures(arr: angles) < 3 {
                solutionSteps.append("\\text{Teniendo todas las medidas} \\\\ \\text{de los lados, por ley de cosenos}\\\\ ")
                lines = lines + 2
            }
            for i in 0...2 {
                let num = sides[i]! * sides[i]! - sides[(i + 1) % 3]! * sides[(i + 1) % 3]! - sides[(i + 2) % 3]! * sides[(i + 2) % 3]!
                let den = (0 - 2 * sides[(i + 1) % 3]! * sides[(i + 2) % 3]!)
                let cosAngle = num / den
                if angles[i] == nil {
                    solutionSteps.append("cos(\(anglesNames[i]))=\\frac{\(sideNames[i])^{2}-\(sideNames[(i + 1) % 3])^{2}-\(sideNames[(i + 2) % 3])^{2}}{-2 \(sideNames[(i + 1) % 3])\(sideNames[(i + 2) % 3])}=\(numToStr(num: radiansToDegrees(radians: acos(cosAngle))))^{o}\\\\")
                    lines = lines + 1
                }
                angles[i] = radiansToDegrees(radians: acos(cosAngle))
            }
        }
        else{
            for i in 0...2 {
                if sides[(i + 1) % 3] != nil && sides[(i + 2) % 3] != nil && angles[i] != nil && sides[i] == nil {
                    // use the law of sines to calc sides[i]
                    sides[i] = sides[(i + 1) % 3]! * sides[(i + 1) % 3]! +
                        sides[(i + 2) % 3]! * sides[(i + 2) % 3]! -
                        2 * sides[(i + 1) % 3]! * sides[(i + 2) % 3]! * cos(degreesToRadians(degrees: angles[i]!))
                    sides[i] = sides[i]!.squareRoot()
                    solutionSteps.append("\\text{Por ley de cosenos,}\\\\ \(sideNames[i])^{2}=\(sideNames[(i + 1) % 3])^{2}+\(sideNames[(i + 2) % 3])^{2}-2 \(sideNames[(i + 1) % 3]) \(sideNames[(i + 2) % 3]) \\cdot cos(\(anglesNames[i]))=\(numToStr(num: sides[i]! * sides[i]!))\\\\ ")
                    lines = lines + 2
                    solutionSteps.append("\(sideNames[i])=\\sqrt{\(numToStr(num: sides[i]! * sides[i]!))}=\(numToStr(num: sides[i]))\\\\ ")
                    lines = lines + 1
                }
            }
        }
    }
    
    func parseTextFields(textFields: [UITextField]!, targetArr: inout [Double?]){
        for i in 0..<textFields.count {
            let str = textFields[i].text
            if !str!.trimmingCharacters(in: .whitespaces).isEmpty{
                let measure = Double(str!)
                targetArr[i] = measure!
            }
            else { targetArr[i] = nil }
        }
    }
    
    // MARK: - Validation methods
    
    func validateSumOfAngles() -> Bool {
        var sum = 0.0
        for i in 0...2 {
            if angles[i] == nil { return false }
            sum = sum + angles[i]!
        }
        return closeCompare(numA: sum - 180.0, numB: 0.0)
    }
  
    func validateLawOfSines() -> Bool {
        var ratio: Double? = nil
        for i in 0...2 {
            if angles[i] != nil && sides[i] != nil {
                if ratio != nil {
                    print(sin(degreesToRadians(degrees: angles[i]!)) / sides[i]!)
                    if !closeCompare(numA: ratio!, numB: sin(degreesToRadians(degrees: angles[i]!)) / sides[i]!) {
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
            if sides[i]! + sides[ (i + 1) % 3 ]! <= sides[ (i + 2) % 3 ]! { return false }
        }
        return true
    }
    
    func validateDoubleType(textFields: [UITextField]!) -> Bool {
        for i in 0..<textFields.count {
            let str = textFields[i].text
            if !str!.trimmingCharacters(in: .whitespaces).isEmpty{
                // try to make it a number
                if Double(str!) == nil { return false }
            }
        }
        return true
    }
    
    func validateExclusiveRange(arr: [Double?], lowerBound: Double?, upperBound: Double?) -> Bool {
        for i in 0..<arr.count {
            if arr[i] != nil{
                if lowerBound != nil {
                    if arr[i]! <= lowerBound! { return false }
                }
                if upperBound != nil {
                    if arr[i]! >= upperBound! { return false }
                }
            }
        }
        return true
    }
    
    func validateInput() -> Bool{
        if !validateDoubleType(textFields: tfSides) || !validateDoubleType(textFields: tfAngles) {
            showAlert(message: ERROR_MESSAGES[0])
            return false
        }
        parseTextFields(textFields: tfSides, targetArr: &sides)
        parseTextFields(textFields: tfAngles, targetArr: &angles)
        if !validateExclusiveRange(arr: sides, lowerBound: 0.00, upperBound: nil) || !validateExclusiveRange(arr: angles, lowerBound: 0.00, upperBound: 180.0) {
            showAlert(message: ERROR_MESSAGES[1])
            return false
        }
        var sum = 0.0
        for i in 0...2 {
            if angles[i] != nil {
                sum = sum + angles[i]!
            }
        }
        let anglesProvided = countProvidedMeasures(arr: angles)
        if anglesProvided == 3 && !closeCompare(numA: 180.0, numB: sum){
            showAlert(message: ERROR_MESSAGES_ANGLES[0])
            return false
        } else if sum >= 180 && anglesProvided < 3 {
            showAlert(message: ERROR_MESSAGES_ANGLES[1])
            return false
        }
        return true
    }
    
    func angleInSet(ang: Double) -> Bool {
        var num = pow(sides[2]!, 2) + pow(sides[1]!, 2) - pow(sides[0]!, 2)
        var a = acos(num / (2.0 * sides[2]! * sides[1]!))
        num = pow(sides[0]!, 2) + pow(sides[2]!, 2) - pow(sides[1]!, 2)
        var b = acos(num / (2.0 * sides[0]! * sides[2]!))
        num = pow(sides[0]!, 2) + pow(sides[1]!, 2) - pow(sides[2]!, 2)
        var c = acos(num / (2.0 * sides[0]! * sides[1]!))
        a = radiansToDegrees(radians: a)
        b = radiansToDegrees(radians: b)
        c = radiansToDegrees(radians: c)
        if !closeCompare(numA: a, numB: ang) &&
            !closeCompare(numA: b, numB: ang) &&
            !closeCompare(numA: c, numB: ang){
            showAlert(message: ERROR_MESSAGES[2])
            return false
        }
        return true
    }
    
    func validateTriangleMeasures() -> Bool {
        // Validate depending on the amount of sides
        let anglesProvided = countProvidedMeasures(arr: angles)
        let sidesProvided = countProvidedMeasures(arr: sides)
        switch anglesProvided {
        case 0:
            if sidesProvided == 3 {
                if !validateTriangleInequality() {
                    showAlert(message: ERROR_MESSAGES_SIDES[0])
                    return false
                }
            }
            else{
                showAlert(message: ERROR_MESSAGES_SIDES[1])
                return false
            }
        case 1:
            // must provide at least 2 sides
            if sidesProvided <= 1 {
                showAlert(message: ERROR_MESSAGES_SIDES[2])
                return false
            }
            else{
                if sidesProvided == 3{
                    var ang = 0.0
                    if angles[0] != nil{
                        ang = angles[0]!
                    }
                    else if angles[1] != nil {
                        ang = angles[1]!
                    }
                    else{
                        ang = angles[2]!
                    }
                    if !angleInSet(ang: ang){
                        return false
                    }
                }
                solveMeasures()
                if !validateSumOfAngles() || !validateTriangleInequality() {
                    showAlert(message: ERROR_MESSAGES[2])
                    return false
                }
            }
        default:
            if sidesProvided == 0 {
                showAlert(message: ERROR_MESSAGES[2])
                return false
            }
            if !validateLawOfSines() || !validateSumOfAngles(){
                showAlert(message: ERROR_MESSAGES[2])
                return false
            }
        }
        return true
    }
    
    func solveMeasures() {
        for _ in 0...2 {
            iterateSumOfAngles()
            iterateLawOfSines()
            iterateLawOfCosines()
        }
    }
    
    // MARK: - Alert methods
    
    func showAlert(message: String?){
        let title = message != nil ? "Valores Incorrectos": "Éxito"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation methods
    
    @IBAction func unwindPlayground(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "popOverSegue" ||
            identifier == "playgroundSegue" {
            clearData()
            if validateInput() {
                addCurrentMeasuresToSolutionSteps()
                iterateSumOfAngles()
                if validateTriangleMeasures(){
                    solveMeasures()
                    return true
                }
            }
            clearData()
            return false
        }
        return true
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        quitaTeclado()
        if segue.identifier == "popOverSegue" {
            let popOverView = segue.destination as! SolutionPopOverViewController
            popOverView.popoverPresentationController?.delegate = self
            popOverView.popoverPresentationController?.sourceRect = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
            popOverView.popoverPresentationController?.sourceView = self.view
            popOverView.width = self.view.frame.width - 20
            popOverView.height = self.view.frame.height - 20
            popOverView.solutionSteps = solutionSteps
            popOverView.lines = lines
        }
        else if segue.identifier == "playgroundSegue" {
            let playgroundView = segue.destination as! PlaygroundViewController
            playgroundView.dAngle1 = angles[0]!
            playgroundView.dAngle2 = angles[1]!
            playgroundView.dAngle3 = angles[2]!
            playgroundView.dSide1 = sides[0]!
            playgroundView.dSide2 = sides[1]!
            playgroundView.dSide3 = sides[2]!
        }
    }
}
