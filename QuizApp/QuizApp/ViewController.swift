//
//  ViewController.swift
//  QuizApp
//
//  Created by Tianhui Zhou on 8/25/20.
//  Copyright © 2020 Tianhui Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = Quizmodel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set self as the delegate and datasource for the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        //set up the model
        model.delegate = self
        model.getQuestion()
    }
    
    func displayQuestion() {
        guard questions.count > 0 && currentQuestionIndex < questions.count else {
            return
        }
        
        //display the question
        questionLabel.text = questions[currentQuestionIndex].question
        
        tableView.reloadData()
    }
    
    // MARK: - QuizProtocol methods
    
    func questionRetrieved(_ questions: [Question]) {
        
        self.questions = questions
        
        //display the first question
        displayQuestion()
        
    }
    
    // MARK: - UITableVIew delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard questions.count > 0 else {
            return 0
        }
        
        //return the number of answers for the question
        if questions[currentQuestionIndex].answers != nil {
            return questions[currentQuestionIndex].answers!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        //customize it
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil {
            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count {
                label!.text = question.answers![indexPath.row]
                
            }
        }
        
        //return cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //user has chosen on a row, check if it is the right answer
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex! == indexPath.row {
            // user got it right
            
        } else {
            //user got it wrong
            
        }
        
        currentQuestionIndex += 1
        
        displayQuestion()
    }

}

