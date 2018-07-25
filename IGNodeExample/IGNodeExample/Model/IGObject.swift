//
//  Parse.swift
//  YanNuo
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 enjoy. All rights reserved.
//

import Foundation

public class IGObject : NSObject, JSONParsable {
    
    @discardableResult
    func frome(json: Any) -> Bool {
        return false
    }
    
    var json: Any {
        fatalError("Not implement")
    }
    
    public override required init() {
        super.init()
    }
}


protocol JSONParsable {
    
    func frome(json: Any) -> Bool
    func filter(json: Any) -> Any?
    var json : Any { get }
}

extension JSONParsable {
    
    func filter(json : Any) -> Any? {
        return json
    }
}

extension JSONParsable where Self : NSObject {
    
    init?(json: Any) {
        
        self.init()
        
        guard let json = self.filter(json: json) else { return nil}
        
        if !self.frome(json: json) {
            return nil
        }
    }
}

extension Array where Element : JSONParsable, Element : NSObject {
    
    init?(json: Any?) {
        guard let array = json as? [Any] else { return nil }
        self = array.flatMap { Element(json: $0) }
    }
    
    var json :[Any] {
        return self.map { $0.json }
    }
    
    
    mutating func frome(json: [Any]) -> Bool {
        
        if let reval = Array<Element>(json : json) {
            self = reval
            return true
        } else {
            return false
        }
    }
    
}

