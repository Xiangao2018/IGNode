//
//  IGURLBridgeInfo.swift
//  iPhoneGame
//
//  Created by enjoy on 2018/4/10.
//  Copyright © 2018年 enjoy. All rights reserved.
//

import Foundation

typealias IGURLBridgeOptionsInfo = [IGURLBridgeInfoItem]

enum IGURLBridgeInfoItem {
    
    case iGameApp
    
    case httpWeb
    
    case universalLink
}

precedencegroup ItemComparisonPrecedence {
    associativity: none
    higherThan: LogicalConjunctionPrecedence
}

infix operator <== : ItemComparisonPrecedence

func <== (lhs: IGURLBridgeInfoItem, rhs: IGURLBridgeInfoItem) -> Bool {
    
    switch (lhs, rhs) {
    case (.iGameApp, .iGameApp): return true
    case (.httpWeb, .httpWeb): return true
    case (.universalLink, .universalLink): return true
    default: return false
    }
}

extension Collection where Iterator.Element == IGURLBridgeInfoItem {
    
    func lastMatchIgnoringAssociatedValue(_ target: Iterator.Element) -> Iterator.Element? {
        return reversed().first { $0 <== target }
    }
    
    func removeAllMatchesIgnoringAssociatedValue(_ target: Iterator.Element) -> [Iterator.Element] {
        return filter { !($0 <== target) }
    }
}

extension Collection where Iterator.Element == IGURLBridgeInfoItem {
    
    var iGameAppUrlBridge: IGameAppURLBridge? {
        if let item = lastMatchIgnoringAssociatedValue(.iGameApp),
            case .iGameApp = item
        {
            return IGameAppURLBridge.default
        }
        return nil
    }
    
    var httpWebUrlBridge: HttpWebURLBridge? {
        if let item = lastMatchIgnoringAssociatedValue(.httpWeb),
            case .httpWeb = item
        {
            return HttpWebURLBridge.default
        }
        return nil
    }
    
    var universalUrlBridge: UniversalLinURLBridge? {
        if let item = lastMatchIgnoringAssociatedValue(.universalLink),
            case .universalLink = item
        {
            return UniversalLinURLBridge.default
        }
        return nil
    }
}
