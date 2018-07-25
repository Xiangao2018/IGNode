//
//  IGNode.swift
//  iPhoneGame
//
//  Created by enjoy on 2018/4/11.
//  Copyright © 2018年 enjoy. All rights reserved.
//

import Foundation
import UIKit

public enum IGHandlerAction {
    case ignoring
    case handling(()->Void)
}

protocol IGHandlerable {
    func handler(forIns instruction: IGInstruction) -> IGHandlerAction
}

extension IGHandlerAction {
    
    @discardableResult
    public func handle() -> Bool {
        switch self {
        case .handling(let handler):
            handler()
        default:
            break
        }
        return self.isHandling
    }
    
    public var isHandling: Bool {
        switch self {
        case .handling(_):
            return true
        case .ignoring:
            return false
        }
    }
    
    public var hasAction: Bool {
        switch self {
        case .handling(_):
            return true
        default:
            return false
        }
    }
}


protocol IGNode {
    
    var igHanderable: IGHandlerable? { get }
    
    var firstIGNode: IGNode { get }
    
    var nextIGNode: IGNode? { get }
    
    @discardableResult
    func handlerInChain(forIG instruction: IGInstruction, fromFirstNode: Bool) -> IGHandlerAction
}

extension IGNode where Self: UIResponder {
    
    var nextIGNode: IGNode? {
        
        var next = self.next
        while next != nil {
            if let node = next as? IGNode {
                return node
            }
            next = next?.next
        }
        return nil
    }
}

extension IGNode {
    
    func handlerInChain(forIG instruction: IGInstruction, fromFirstNode: Bool) -> IGHandlerAction {
        if fromFirstNode {
            return self.firstIGNode.handlerInChain(forIG: instruction, fromFirstNode: false)
        } else {
            if let action = self.igHanderable?.handler(forIns: instruction), action.isHandling {
                return action
            } else {
                return self.nextIGNode?.handlerInChain(forIG: instruction, fromFirstNode: false) ?? .ignoring
            }
        }
    }
    var firstIGNode: IGNode { return self }
}
