//
//  SolutionPopOverViewController.swift
//  Trigvia
//
//  Created by Alumno on 4/26/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit
import iosMath

class SolutionPopOverViewController: UIViewController {

    var width: CGFloat!
    var height: CGFloat!
    
    var solutionSteps = [String]()
    
    let latexlabel = MTMathUILabel()
    let OKbtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: width, height: height)
        createSolutionLabel()
    }
    
    func createSolutionLabel() {
        self.view.addSubview(latexlabel)
        latexlabel.backgroundColor = .white
        latexlabel.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        latexlabel.textAlignment = .center
        latexlabel.latex = "\\begin{gather} "
        for i in 0..<solutionSteps.count {
            latexlabel.latex?.append(solutionSteps[i])
        }
        latexlabel.latex?.append("\\end{gather}")
    }
    
    @IBAction func closePopOver() {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */

}
