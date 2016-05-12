//
//  Constants.swift
//  swifty_companion
//
//  Created by Florin BICHER on 5/6/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import Foundation

let Intra = [
    "consumerKey": "INTRA_CONSUMER_KEY",
    "consumerSecret": "INTRA_COMSUMER_SECRET",
    "authorizeUrl": "https://api.intra.42.fr/oauth/authorize",
    "accessTokenUrl": "https://api.intra.42.fr/oauth/token",
    "repsonseType": "code",
    "redirectUri": "fr.42.fbicher://oauth-callback/swifty_companion"
]

let EMPTY_LOGIN_ERROR_CODE = -888

struct Strings {
    static let AlertActionOk = NSLocalizedString("Ok", comment: "Confirm button text on alerts")
    static let AlertTitleEmptyLogin = NSLocalizedString("Empty login field", comment: "Title of alert that shows up when user presses the search button without providing a login")
    static let AlertMessageEmptyLogin = NSLocalizedString("Please provide the login", comment: "Message of alert that shows up when user presses the search button without providing a login")
    static let AlertTitleUserNotFound = NSLocalizedString("User not found", comment: "Title of alert that shows up when no user was found for the login provided")
    static let AlertMessageUserNotFound = NSLocalizedString("Check the login spelling", comment: "Message of alert that shows up when no user was found for the login provided")
    static let AlertTitleFetchingError = NSLocalizedString("User fetching error: %@", comment: "Title of alert that shows up when an error while fetching the use occurs")
    static let AlertMessageFetchingError = NSLocalizedString("Try again", comment: "Message of alert that shows up when an error while fetching the use occurs")
    static let LocationNotAvailable = NSLocalizedString("Not Available", comment: "Label that is set when user location is unknown")
}
