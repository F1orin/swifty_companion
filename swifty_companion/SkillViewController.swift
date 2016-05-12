//
//  SkillsTableViewController.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: UserObject?
    
    private struct Storyboard {
        static let CellReuseIdentifier = "skill"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        user = ProfileManager.sharedInstance.user
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (user != nil) {
            return user!.skills.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! SkillTableViewCell

        cell.skill = user?.skills[indexPath.row]
        
        return cell
    }
}
