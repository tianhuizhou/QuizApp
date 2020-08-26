//
//  QuizModel.swift
//  QuizApp
//
//  Created by Tianhui Zhou on 8/25/20.
//  Copyright © 2020 Tianhui Zhou. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    func questionRetrieved(_ question:[Question])
}

class Quizmodel {
    
    var delegate: QuizProtocol?
    
    func getQuestion() {
        
        //Fetch data from Json file
        getLocalJsonFile()
        
        
    }
    
    func getLocalJsonFile() {
        
        //get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        //check the path if it is not nil
        guard path != nil else{
            print("Could not find the json file")
            return
        }
        
        //create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        //get the data from the URL
        //handle the error if cannot convert data from Json file
        do {
            let data = try Data(contentsOf: url)
            
            //try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            delegate?.questionRetrieved(array)
        } catch {
            
        }
    }
    
    func getRemoteJsonFile() {
        
    }
}
