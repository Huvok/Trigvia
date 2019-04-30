//
//  InfoViewController.swift
//  Trigvia
//
//  Created by Alumno on 4/30/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func dataPath() -> String {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("AnsweredQuestions.plist")
        return pathArchivo.path
    }

    @IBAction func resetApp(_ sender: Any) {
        do {
            try _ = FileManager.default.removeItem(atPath: dataPath())
        }
        catch {
            print("No se encontró el plist")
        }
        
        let champ : NSMutableArray = []
        champ.write(toFile: dataPath(), atomically: true)
    }
}
