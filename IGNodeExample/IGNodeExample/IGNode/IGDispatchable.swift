//
//  IGDispatchable.swift
//  iPhoneGame
//
//  Created by enjoy on 2018/7/25.
//  Copyright © 2018 enjoy. All rights reserved.
//

import Foundation

protocol IGDispatchable: IGHandlerable  {
    
    func handleSpecialExercise() -> IGHandlerAction
    
    func handleExaminationPaper() -> IGHandlerAction
    
    func handleRedoWrong() -> IGHandlerAction
    
    func handleCollection() -> IGHandlerAction
    
    func handleMyNote() -> IGHandlerAction
    
    func handleRefreshQuestionSet() -> IGHandlerAction
    
}

extension IGDispatchable {
    
    func handler(forIns instruction: IGInstruction) -> IGHandlerAction {
        switch instruction.type {
        case .specialExercise:
            return self.handleSpecialExercise()
        case .examinationPaper:
            return self.handleExaminationPaper()
        case .redoWrong:
            return self.handleRedoWrong()
        case .collection:
            return self.handleCollection()
        case .myNote:
            return self.handleMyNote()
        case .refreshQuestionSet:
            return self.handleRefreshQuestionSet()
        case .unKnown: return .ignoring
                        
        }
    }
}
