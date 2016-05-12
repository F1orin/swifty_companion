//
//  UserObject.swift
//  swifty_companion
//
//  Created by Florin BICHER on 4/30/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import SwiftyJSON

class UserObject {
    
    var id: String!
    var email: String!
    var login: String!
    var phone: String!
    var displayName: String!
    var imageUrl: String!
    var correctionPoints: String!
    var location: String!
    var wallet: Int!
    var skills = [SkillObject]()
    var projects = [ProjectObject]()
    var level: Float!
    var hasCursus42 = false
    
    required init(json: JSON) {
        id = json["id"].stringValue
        email = json["email"].stringValue
        login = json["login"].stringValue
        phone = json["phone"].stringValue
        displayName = json["displayname"].stringValue
        imageUrl = json["image_url"].stringValue
        correctionPoints = json["correction_point"].stringValue
        location = json["location"].stringValue
        wallet = json["wallet"].intValue
        // parse skills
        if let cursus = json["cursus"].array {
            for entry in cursus {
                let cursus_name = entry["cursus"]["slug"].stringValue
                if cursus_name == "42" {
                    hasCursus42 = true
                    if let skls = entry["skills"].array {
                        for skill in skls {
                            self.skills.append(SkillObject(json: skill))
                        }
                    }
                }
            }
        }
        // parse projects
        if let cursus = json["cursus"].array {
            for entry in cursus {
                let cursus_name = entry["cursus"]["slug"].stringValue
                if cursus_name == "42" {
                    if let prjs = entry["projects"].array {
                        for project in prjs {
                            self.projects.append(ProjectObject(json: project))
                        }
                    }
                    level = entry["level"].floatValue
                }
            }
        }
        
        // sort arrays
        skills.sortInPlace({ $0.level > $1.level })
        projects.sortInPlace({ $0.slug < $1.slug })
    }
    
    func toString() {
        print("user:\n  id: \(id)\n  email: \(email)\n  login: \(login)\n  phone: \(phone)\n  display_name: \(displayName)\n  image_url: \(imageUrl)\n  correction_points: \(correctionPoints)\n  location: \(location)\n  wallet: \(wallet)\n  level: \(level)")
        for entry in skills {
            entry.toString()
        }
        for entry in projects {
            entry.toString()
        }
    }
}
