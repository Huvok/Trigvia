//
//  InfoViewController.swift
//  Trigvia
//
//  Created by Alumno on 4/30/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var tContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tContainerView.layer.cornerRadius=8
        // Do any additional setup after loading the view.
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
