//
//  ProfileManager.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/4/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import Foundation
import SwiftyJSON
import OAuthSwift

class ProfileManager: NSObject {
    
    static let sharedInstance = ProfileManager()
    
    internal var oauthIntra: OAuth2Swift = OAuth2Swift(
        consumerKey:    Intra["consumerKey"]!,
        consumerSecret: Intra["consumerSecret"]!,
        authorizeUrl:   Intra["authorizeUrl"]!,
        accessTokenUrl: Intra["accessTokenUrl"]!,
        responseType: Intra["repsonseType"]!
    )

    internal var user: UserObject?
    
    func searchUser(login: String, successHandler: () -> Void, failureHandler: (code: Int) -> Void) {
        oauthIntra.client.get(
            "https://api.intra.42.fr/v2/users/" + login,
            success: { data, response in
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                self.loadUserFromJsonString(dataString as! String)
                successHandler()
            },
            failure: { error in
                if error.code == 401 {
                    self.doOAuthIntra(login, successHandler: successHandler, failureHandler: failureHandler)
                } else {
                    failureHandler(code: error.code)
                }
            }
        )
    }
    
    private func doOAuthIntra(login: String, successHandler: () -> Void, failureHandler: (code: Int) -> Void) {
        let state: String = generateStateWithLength(20) as String
        ProfileManager.sharedInstance.oauthIntra.authorizeWithCallbackURL(
            NSURL(string: Intra["redirectUri"]!)!,
            scope: "public", state: state,
            success: { credential, response, parameters in
                self.searchUser(login, successHandler: successHandler, failureHandler: failureHandler)
            },
            failure: { error in
                print(error.localizedDescription, terminator: "")
            }
        )
    }
    
    private func loadUserFromJsonString(jsonString: String) {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let userJson = JSON(data: dataFromString)
            user = UserObject(json: userJson)
        }
    }
}
