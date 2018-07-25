//
//  AppDelegate+Instruction.swift
//  iPhoneGame
//
//  Created by enjoy on 2018/4/10.
//  Copyright © 2018年 enjoy. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate: IGNode {
    
    var igHanderable: IGHandlerable? {
        return self
    }
    
    var firstIGNode: IGNode {
        return self.window?.rootViewController?.firstIGNode ?? self
    }
}

extension AppDelegate: IGDispatchable {
    
    func handleSpecialExercise() -> IGHandlerAction {
        return .handling({
            print("Handler handleSpecialExercise")
        })
    }
    
    func handleExaminationPaper() -> IGHandlerAction {
        return .handling({
            print("Handler handleExaminationPaper")
        })
        
    }
    
    func handleRedoWrong() -> IGHandlerAction {
        return .handling({
            print("Handler handleRedoWrong")
        })
    }
    
    func handleCollection() -> IGHandlerAction {
        return .handling({
            print("Handler handleCollection")
        })
    }
    
    func handleMyNote() -> IGHandlerAction {
        return .handling({
            print("Handler handleMyNote")
        })
    }
    
    func handleRefreshQuestionSet() -> IGHandlerAction {
        return .handling({
            print("Handler handleRefreshQuestionSet")
        })
    }
}


extension AppDelegate {
    
    @objc static let current: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @discardableResult
    func handleIGURL(_ url: URL, httpConvertible: Bool = true) -> Bool {
        
        guard let instruction = IGInstruction(url: url, options: httpConvertible ? [.iGameApp, .httpWeb] : [.iGameApp]) else { return false }
        
        return handleIGInstruction(instruction)
    }
    
    func handleIGInstruction(_ ins: IGInstruction) -> Bool {
        
        switch ins.type {
        case .specialExercise, .examinationPaper, .redoWrong, .collection, .myNote, .refreshQuestionSet:
                self.firstIGNode.handlerInChain(forIG: ins, fromFirstNode: false).handle()
        default:
                break
        }
        return true
        
    }
}
