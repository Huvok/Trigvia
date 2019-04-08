//
//  ViewController.swift
//  Trigvia
//
//  Created by Alumno on 3/22/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class QuestionViewController : UIViewController {
    
    var difficulty : String!
    
    @IBOutlet weak var lbDifficulty: UILabel!
    @IBOutlet weak var lbTopic: UILabel!
    @IBOutlet weak var lbQuestion: UILabel!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    @IBOutlet weak var btnOption4: UIButton!
    
    var arrQuestions = [Question]()
    var arrQuestionsDic : NSArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Property List", ofType: "plist")!
        let dicPList : NSDictionary!
        dicPList = NSDictionary(contentsOfFile: path)
        
        lbDifficulty.text = difficulty
        if difficulty == "Fácil" {
            
        }
        else if difficulty == "Medio" {
            
        }
        else {
            
        }
    }


}

