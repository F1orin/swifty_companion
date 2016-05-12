//
//  ProfileViewController.swift
//  swifty_companion
//
//  Created by Florin BICHER on 4/27/16.
//  Copyright © 2016 Florin BICHER. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class ProfileViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var progressHolderView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var user: UserObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.hidden = true
        
        // set corner rounding to progress bar
        progressHolderView.layer.cornerRadius = 7.5
        progressHolderView.layer.masksToBounds = true
        progressHolderView.clipsToBounds = true
        
        user = ProfileManager.sharedInstance.user
        if (user != nil && user!.hasCursus42) {
            nameLabel.text = user!.displayName
            loginLabel.text = user!.login
            phoneLabel.text = user!.phone
            emailLabel.text = user!.email
            walletLabel.text = String(user!.wallet)
            
            // set up location
            if user!.location.characters.count > 0 {
                locationLabel.text = user!.location
            } else {
                locationLabel.text = Strings.LocationNotAvailable
            }
            
            // set up level
            let level = String(Int(user!.level))
            let percent = String(Int(round(user!.level % 1 * 100)))
            levelLabel.text = "\(level) - \(percent)%" // todo fix this
            progressView.progress = user!.level % 1
            
            // fetch image
            if let url = NSURL(string: user!.imageUrl) {
                
                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                    size: photoImageView.frame.size,
                    radius: photoImageView.frame.width
                )
                
                photoImageView.af_setImageWithURL(
                    url,
                    filter: filter,
                    imageTransition: .CrossDissolve(1),
                    completion: { Response in
                        if Response.result.isFailure {
                            let noImageSource = UIImage(named: "dummy_photo")
                            let noImage = noImageSource?.af_imageRoundedIntoCircle()
                            self.photoImageView.image = noImage
                        }
                        self.activityIndicator.stopAnimating()
                        self.photoImageView.hidden = false
                    }
                )
            } else {
                print("bad profile image URL")
            }
        }
    }
}
