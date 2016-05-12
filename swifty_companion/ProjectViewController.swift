//
//  ProjectViewController.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var user: UserObject?
    
    private struct Storyboard {
        static let CellReuseIdentifier = "project"
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
            return user!.projects.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! ProjectTableViewCell
        
        cell.project = user?.projects[indexPath.row]
        
        return cell
    }
}
