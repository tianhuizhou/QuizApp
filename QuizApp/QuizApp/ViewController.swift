//
//  ViewController.swift
//  QuizApp
//
//  Created by Tianhui Zhou on 8/25/20.
//  Copyright © 2020 Tianhui Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol,UITableViewDelegate, UITableViewDataSource, ResultViewControllerProtocol {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = Quizmodel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    var resultDialog: ResultViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resultDialog = storyboard?.instantiateViewController(identifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        resultDialog?.delegate = self
        
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
        
        var titleText = ""
        if question.correctAnswerIndex! == indexPath.row {
            // user got it right
            titleText = "Correct!"
            numCorrect += 1
        } else {
            //user got it wrong
            titleText = "Wrong!"
        }
        
        if resultDialog != nil {
            
            resultDialog!.titleText = titleText
            resultDialog!.feedbackText = question.feedback!
            resultDialog!.buttonText = "Next"
            
            present(resultDialog!, animated: true, completion: nil)
        }
        
        
    }

    //MARK: - ResultViewControllerProtocol methods
    
    func dialogDismissed() {
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            displayQuestion()
            
        } else if currentQuestionIndex == questions.count {
            if resultDialog != nil {
                
                resultDialog!.titleText = "Summary"
                resultDialog!.feedbackText = "You got \(numCorrect) correct of \(questions.count) questions"
                resultDialog!.buttonText = "Restart"
                
                present(resultDialog!, animated: true, completion: nil)
            }
        } else if currentQuestionIndex > questions.count {
            
            numCorrect = 0
            currentQuestionIndex = 0
            displayQuestion()
        }
        
    }
}

