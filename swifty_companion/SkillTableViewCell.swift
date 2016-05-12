//
//  SkillTableViewCell.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    // MARK: Properties

    var skill: SkillObject? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    
    // MARK: Functions
    
    func updateUI() {
        // reset any existing information
        nameLabel.text = nil
        levelLabel.text = nil
        
        if let skill = self.skill {
            nameLabel.text = skill.name
            levelLabel.text = String(Int(skill.level))
            levelProgress.progress = skill.level % 1
        }
    }
}
