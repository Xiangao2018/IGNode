//
//  MainController.swift
//  iPhoneGame
//
//  Created by enjoy on 2018/3/30.
//  Copyright © 2018年 enjoy. All rights reserved.
//

import UIKit

struct MainActionInfo: Codable {
    
    var title: String?
    var detail: String?
    var imageName: String?
    var action: String?
}

final class MainController: NSObject {
    
    public var actionInfos: [MainActionInfo]?
    
    override init() {
        super.init()
    
        if let bundele = Bundle.main.path(forResource: "MainAction.plist", ofType: nil), let array = NSArray(contentsOfFile: bundele), let data = try? JSONSerialization.data(withJSONObject: array, options: []){
            
            if let infos = try? JSONDecoder().decode([MainActionInfo].self, from: data) {
                self.actionInfos = infos
            }
        }
        
    }

}
