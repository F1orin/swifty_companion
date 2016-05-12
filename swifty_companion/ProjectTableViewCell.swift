//
//  ProjectTableViewCell.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import UIKit
//import Foundation

class ProjectTableViewCell: UITableViewCell {

    // MARK: Properties
    
    var project: ProjectObject? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!

    
    // MARK: Functions
    
    func updateUI() {
        // reset any existing information
        nameLabel.text = nil
        markLabel.text = nil
        markLabel.textColor = UIColor(colorLiteralRed: 0, green: 110/255, blue: 112/255, alpha: 1)
        if let project = self.project {
            // set name
            if project.slug.hasPrefix("piscine") || project.slug.hasPrefix("rushes") || project.slug.hasPrefix("first-internship") {
                nameLabel.text = transformSlug(project.slug)
            } else {
                nameLabel.text = project.name
            }
            markLabel.text = String(project.mark)
            // change color of the mark
            if project.mark < 50 {
                markLabel.textColor = UIColor(colorLiteralRed: 169/255, green: 68/255, blue: 66/255, alpha: 1)
            }
        }
    }
    
    private func transformSlug(slug: String) -> String {
        let arr = slug.componentsSeparatedByString("-")
        let tmp = arr.joinWithSeparator(" ")
        let res = tmp.capitalizedString
        return res
    }
}
