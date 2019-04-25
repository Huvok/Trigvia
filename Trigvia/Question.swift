//
//  Question.swift
//  Trigvia
//
//  Created by Alumno on 4/8/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class Question: NSObject {
    var id : Int
    var strTopic : String!
    var strQuestion : String!
    var strAnswer : String!
    var arrStrWA = [String]()
    
    init(id: Int, strTopic : String, strQuestion : String, strAnswer : String, arrStrWA : [String]) {
        self.id = id
        self.strTopic = strTopic
        self.strQuestion = strQuestion
        self.strAnswer = strAnswer
        self.arrStrWA = arrStrWA
    }
}
