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
    
    @IBOutlet weak var btnNextQ: UIButton!
    
    var arrQuestions = [Question]()
    var arrQuestionsDic : NSDictionary = [:]
    var usedQuestions = [Bool]()
    var intCurrentQuestion : Int = 0
    var intAnswerBtn : Int = 0
    var arrSolved : NSMutableArray = []
    
    @IBOutlet weak var questionContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Questions", ofType: "plist")!
        let dicPList : NSDictionary!
        dicPList = NSDictionary(contentsOfFile: path)
        
        let dificultadPList : NSDictionary!
        dificultadPList = dicPList[difficulty] as? NSDictionary
        
        questionContainerView.layer.cornerRadius = 8
        btnNextQ.layer.cornerRadius = 8
        
        for (key, _) in dificultadPList {
            let k = key as! String
            
            let arr : NSArray!
            arr = dificultadPList[k] as? NSArray
            
            for i in 0...arr.count - 1 {
                let dic : NSDictionary!
                dic = arr[i] as? NSDictionary
                arrQuestions.append(Question(id: dic["id"] as! Int, strTopic: key as! String, strQuestion: dic["pregunta"] as! String, strAnswer: dic["respuesta"] as! String, arrStrWA: dic["incorrectas"] as! [String]))
            }
        }
        
        lbDifficulty.text = difficulty
        
        let filePath = dataPath()
        if FileManager.default.fileExists(atPath: filePath) {
            arrSolved = NSMutableArray(contentsOfFile: filePath)!
        }
        if arrQuestions.count > 1{
            nextQuestion()
        }
    }
    
    func dataPath() -> String {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("AnsweredQuestions.plist")
        return pathArchivo.path
    }
    
    func nextQuestion() {
        btnOption1.backgroundColor = .lightGray
        btnOption2.backgroundColor = .lightGray
        btnOption3.backgroundColor = .lightGray
        btnOption4.backgroundColor = .lightGray
        btnNextQ.isHidden = true
        
        let rnd = Int.random(in: 0...arrQuestions.count - 1)
        intCurrentQuestion = arrQuestions[rnd].id
        
        lbTopic.text = arrQuestions[rnd].strTopic
        lbQuestion.text = arrQuestions[rnd].strQuestion
        
        var rndBtn = [Int]()
        rndBtn.append(contentsOf: 1...4)
        
        var cnt : Int = 0
        while rndBtn.count > 1 {
            let auxRnd = Int.random(in: 0...rndBtn.count - 1)
            
            if rndBtn[auxRnd] == 1 {
                btnOption1.setTitle(arrQuestions[rnd].arrStrWA[cnt], for: .normal)
            }
            else if rndBtn[auxRnd] == 2 {
                btnOption2.setTitle(arrQuestions[rnd].arrStrWA[cnt], for: .normal)
            }
            else if rndBtn[auxRnd] == 3 {
                btnOption3.setTitle(arrQuestions[rnd].arrStrWA[cnt], for: .normal)
            }
            else {
                btnOption4.setTitle(arrQuestions[rnd].arrStrWA[cnt], for: .normal)
            }
            
            rndBtn.remove(at: auxRnd)
            cnt = cnt + 1
        }
        
        if rndBtn[0] == 1 {
            btnOption1.setTitle(arrQuestions[rnd].strAnswer, for: .normal)
            intAnswerBtn = 1
        }
        else if rndBtn[0] == 2 {
            btnOption2.setTitle(arrQuestions[rnd].strAnswer, for: .normal)
            intAnswerBtn = 2
        }
        else if rndBtn[0] == 3 {
            btnOption3.setTitle(arrQuestions[rnd].strAnswer, for: .normal)
            intAnswerBtn = 3
        }
        else {
            btnOption4.setTitle(arrQuestions[rnd].strAnswer, for: .normal)
            intAnswerBtn = 4
        }
    }
    
    @IBAction func btn1Click(_ sender: Any) {
        if intAnswerBtn == 1 {
            accepted()
            btnOption1.backgroundColor = .green
            btnOption1.isEnabled = true
            btnOption2.isEnabled = true
            btnOption3.isEnabled = true
            btnOption4.isEnabled = true
        }
        else {
            wrongAnswer()
            btnOption1.backgroundColor = .red
        }
    }
    
    @IBAction func btn2Click(_ sender: Any) {
        if intAnswerBtn == 2 {
            accepted()
            btnOption2.backgroundColor = .green
        }
        else {
            wrongAnswer()
            btnOption2.backgroundColor = .red
        }
    }
    
    @IBAction func btn3Click(_ sender: Any) {
        if intAnswerBtn == 3 {
            accepted()
            btnOption3.backgroundColor = .green
        }
        else {
            wrongAnswer()
            btnOption3.backgroundColor = .red
        }
    }
    
    @IBAction func btn4Click(_ sender: Any) {
        if intAnswerBtn == 4 {
            accepted()
            btnOption4.backgroundColor = .green
        }
        else {
            wrongAnswer()
            btnOption4.backgroundColor = .red
        }
    }
    
    func accepted() {
        btnOption1.isEnabled = false
        btnOption2.isEnabled = false
        btnOption3.isEnabled = false
        btnOption4.isEnabled = false
        let alert = UIAlertController(title: "Respuesta correcta", message: "Puedes seguir a la siguiente pregunta", preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(accion)
        present(alert, animated: true, completion: nil)
        
        btnNextQ.isHidden = false
        
        arrSolved.add(intCurrentQuestion)
        arrSolved.write(toFile: dataPath(), atomically: true)
    }
    
    func wrongAnswer() {
        let alert = UIAlertController(title: "Respuesta incorrecta", message: "No te rindas, champ", preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(accion)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func btnNextQuestion(_ sender: Any) {
        nextQuestion()
        btnOption1.isEnabled = true
        btnOption2.isEnabled = true
        btnOption3.isEnabled = true
        btnOption4.isEnabled = true
    }
}
