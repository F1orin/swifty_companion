//
//  SearchViewController.swift
//  swifty_companion
//
//  Created by Florin BICHER on 4/11/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import UIKit
import OAuthSwift

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        ProfileManager.sharedInstance.oauthIntra.authorize_url_handler = SafariURLHandler(viewController: self)
        loginField.delegate = self
        
        showButton.layer.cornerRadius = 5
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchUser()
        return true
    }
    
    @IBAction func showProfile(sender: UIButton) {
        searchUser()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "show_profile" || identifier == "show_profile_unanimated" {
            if loginField.text!.isEmpty {
                showAlert(EMPTY_LOGIN_ERROR_CODE)
                return false
            }
        }
        return true
    }
    
    private func searchUser() {
        let text = loginField.text!
        let searchString = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if searchString.characters.count == 0 {
            showAlert(EMPTY_LOGIN_ERROR_CODE)
        } else {
            ProfileManager.sharedInstance.searchUser(
                searchString,
                successHandler: {
                    self.performSegueWithIdentifier("show_profile", sender: nil)
                },
                failureHandler: { code in
                    self.showAlert(code)
                }
            )
        }
    }
    
    private func showAlert(code: Int) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        switch code {
        case -888:
            alert.title = Strings.AlertTitleEmptyLogin
            alert.message = Strings.AlertMessageEmptyLogin
            break
        case 404:
            alert.title = Strings.AlertTitleUserNotFound
            alert.message = Strings.AlertMessageUserNotFound
            break
        default:
            alert.title = String.localizedStringWithFormat(Strings.AlertTitleFetchingError, code)
            alert.message = Strings.AlertMessageFetchingError
        }
        
        alert.addAction(UIAlertAction(
            title: Strings.AlertActionOk,
            style: .Default,
            handler: nil)
        )
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
