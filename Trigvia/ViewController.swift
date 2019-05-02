//
//  ViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnTrivia: UIButton!
    @IBOutlet weak var btnPlayground: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnTrivia.layer.cornerRadius = 8
        btnPlayground.layer.cornerRadius = 8
        btnInfo.layer.cornerRadius = 8
    }
    
    @IBAction func unwindPlaygroundAtHome(for unwindSegue: UIStoryboardSegue) {
        //
    }

    @IBAction func unwindInfo(for unwindSegue: UIStoryboardSegue) {
        //
    }
}

