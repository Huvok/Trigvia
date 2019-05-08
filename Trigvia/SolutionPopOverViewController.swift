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
    var lines: Int!
    
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var solutionSteps = [String]()
    
    let latexlabel = MTMathUILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: width, height: height)
        
        scrollView.backgroundColor = .white
        createSolutionLabel()
        scrollView.contentSize = CGSize(width: width, height: CGFloat( Double(lines) * 45 ))
    }
    
    func createSolutionLabel() {
        scrollView.addSubview(latexlabel)
        latexlabel.backgroundColor = .white
        
        latexlabel.textAlignment = .center
        latexlabel.latex = "\\begin{gather} "
        for i in 0..<solutionSteps.count {
            latexlabel.latex?.append(solutionSteps[i])
        }
        latexlabel.latex?.append("\\end{gather}")

        latexlabel.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: CGFloat( Double(lines) * 45 ))
        let labelWidth = latexlabel.frame.width
        latexlabel.frame = CGRect(x: (width - labelWidth) / 2, y: 0, width: scrollView.frame.size.width, height: CGFloat( Double(lines) * 45 ))
    }
    
    @IBAction func closePopOver() {
        dismiss(animated: true, completion: nil)
    }

}
