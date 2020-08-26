//
//  Question.swift
//  QuizApp
//
//  Created by Tianhui Zhou on 8/25/20.
//  Copyright © 2020 Tianhui Zhou. All rights reserved.
//

import Foundation

struct Question: Codable {
    var question: String?
    var answers: [String]?
    var correctAnswerIndex: Int?
    var feedback: String?
}
