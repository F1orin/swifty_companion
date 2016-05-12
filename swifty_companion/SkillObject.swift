//
//  SkillObject.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import SwiftyJSON

class SkillObject {
    
    var id: String!
    var name: String!
    var level: Float!
    
    required init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        level = json["level"].floatValue
    }
    
    func toString() {
        print("  skill:\n    id: \(id)\n    name: \(name)\n    level: \(level)")
    }
}
