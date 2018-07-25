//
//  IGBridge.swift
//  eziNode
//
//  Created by enjoy on 2018/4/9.
//  Copyright © 2018年 enjoy. All rights reserved.
//

import Foundation

protocol IGBridge {
    
    func bridgeToIG(from url: URL?) -> IGInstruction?
    
    func bridgeToURL(from instruction: IGInstruction?) -> URL?
}

fileprivate func makeDictionary(fromQueryItems items:[URLQueryItem]?) -> [String : String] {
    var queries = [String: String]()
    
    for item in items ?? [] {
        queries[item.name] = item.value
    }
    
    return queries
}

fileprivate func makeQueryItems(fromDictionary dict: [String: String]?) -> [URLQueryItem] {
    
    return dict?.map({ URLQueryItem(name: $0, value: $1) }) ?? []
}

class IGameAppURLBridge: IGBridge {
    
    private static let iGameAppScheme = "igame"
    
    static let `default` = IGameAppURLBridge()
    
    func bridgeToIG(from url: URL?) -> IGInstruction? {
        
        guard let url = url else { return nil }
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true), urlComponents.scheme?.lowercased() == IGameAppURLBridge.iGameAppScheme else { return nil }
        
        guard let host = urlComponents.host else { return nil }
        
        let queries = makeDictionary(fromQueryItems: urlComponents.queryItems)
        
        let components = urlComponents.path.components(separatedBy: "/").filter { !$0.isEmpty }
        
        let instruction = IGInstruction(type: IGInstructionType(identifier: host), components: components, queryItems: queries, bridge: self)
        
        return instruction
    }
    
    func bridgeToURL(from instruction: IGInstruction?) -> URL? {
        assertionFailure("Not Implement")
        return nil
    }
    
}

class HttpWebURLBridge: IGBridge {
    
    private static let httpScheme = "http"
    
    static let `default` = HttpWebURLBridge()
    
    func bridgeToIG(from url: URL?) -> IGInstruction? {
        
        guard let url = url else { return nil }
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true), urlComponents.scheme?.lowercased() == HttpWebURLBridge.httpScheme else { return nil }
        
        guard let host = urlComponents.host else { return nil }
        
        let queries = makeDictionary(fromQueryItems: urlComponents.queryItems)
        
        let components = urlComponents.path.components(separatedBy: "/").filter { !$0.isEmpty }
        
        let instruction = IGInstruction(type: IGInstructionType(identifier: host), components: components, queryItems: queries, bridge: self)
        
        return instruction
    }
    
    func bridgeToURL(from instruction: IGInstruction?) -> URL? {
        assertionFailure("Not Implement")
        return nil
    }
}

class UniversalLinURLBridge: IGBridge {
    
    private static let universalLinkScheme = "http"
    
    static let `default` = UniversalLinURLBridge()
    
    func bridgeToIG(from url: URL?) -> IGInstruction? {
        
        guard let url = url else { return nil }
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true), urlComponents.scheme?.lowercased() == UniversalLinURLBridge.universalLinkScheme else { return nil }
        
        guard let host = urlComponents.host else { return nil }
        
        let queries = makeDictionary(fromQueryItems: urlComponents.queryItems)
        
        let components = urlComponents.path.components(separatedBy: "/").filter { !$0.isEmpty }
        
        let instruction = IGInstruction(type: IGInstructionType(identifier: host), components: components, queryItems: queries, bridge: self)
        
        return instruction
    }
    
    func bridgeToURL(from instruction: IGInstruction?) -> URL? {
        assertionFailure("Not Implement")
        return nil
    }
}



