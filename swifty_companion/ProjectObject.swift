//
//  ProjectObject.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import SwiftyJSON

class ProjectObject {
    
    var id: String!
    var name: String!
    var slug: String!
    var mark: Int!
    
    required init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        slug = json["slug"].stringValue
        mark = json["final_mark"].intValue
    }
    
    func toString() {
        print("  project:\n    id: \(id)\n    name: \(name)\n    slug: \(slug)\n  mark: \(mark)")
    }
}
