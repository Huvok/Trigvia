//
//  Question.swift
//  Trigvia
//
//  Created by Alumno on 4/8/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class Question: NSObject {
    var strQuestion : String!
    var strAnswer : String!
    var arrStrOptions = [String]()
    
    init(strQuestion : String, strAnswer : String, arrStrOptions : [String]) {
        self.strQuestion = strQuestion
        self.strAnswer = strAnswer
        self.arrStrOptions = arrStrOptions
    }
}
