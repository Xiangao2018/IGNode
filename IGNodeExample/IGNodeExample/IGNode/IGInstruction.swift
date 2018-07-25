//
//  IGInstruction.swift
//  eziNode
//
//  Created by enjoy on 2018/4/9.
//  Copyright © 2018年 enjoy. All rights reserved.
//

import Foundation

public enum IGInstructionType: String {
    
    case specialExercise
    case examinationPaper
    case redoWrong
    case collection
    case myNote
    case refreshQuestionSet
    case unKnown
    
    init(identifier: String?) {
        guard let identifier = identifier else { self = .unKnown;  return }
        
        switch identifier {
        case IGInstructionType.specialExercise.rawValue:
            self = .specialExercise
        case IGInstructionType.examinationPaper.rawValue:
            self = .examinationPaper
        case IGInstructionType.redoWrong.rawValue:
            self = .redoWrong
        case IGInstructionType.collection.rawValue:
            self = .collection
        case IGInstructionType.myNote.rawValue:
            self = .myNote
        case IGInstructionType.refreshQuestionSet.rawValue:
            self = .refreshQuestionSet
        default:
            self = .unKnown
        }
    }
    
}

struct IGInstruction {
    
    let type: IGInstructionType
    
    let components: [String]
    
    var path: String {
        return self.components.isEmpty ? "" : ([""] + self.components).joined(separator: "/")
    }
    
    let queryItems: [String: String]
    
    var bridge: IGBridge?
    
    init(type: IGInstructionType,  components: [String] = [], queryItems: [String: String] = [:], bridge: IGBridge? = nil ) {
        self.type = type
        self.components = components
        self.queryItems = queryItems
        self.bridge = bridge
    }
}

extension IGInstruction {
    
    init?(url: URL?, options: IGURLBridgeOptionsInfo = [.iGameApp]) {
        
        if let bridge = options.iGameAppUrlBridge, let ins = bridge.bridgeToIG(from: url) {
            self = ins
            return
        }
        
        if let bridge = options.httpWebUrlBridge, let ins = bridge.bridgeToIG(from: url) {
            self = ins
            return
        }
        
        if let bridge = options.universalUrlBridge, let ins = bridge.bridgeToIG(from: url) {
            self = ins
            return
        }
        
        return nil
    }
}

extension IGInstruction {
    
    var url: URL? {
        return self.bridge?.bridgeToURL(from: self)
    }
}
