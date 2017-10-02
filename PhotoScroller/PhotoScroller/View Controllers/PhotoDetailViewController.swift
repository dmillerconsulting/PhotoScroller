//
//  PhotoDetailViewController.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo? {
        didSet {
            DispatchQueue.main.async {
                guard self.isViewLoaded else { return }
                self.updateViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    //MARK: IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) { }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let textToShare = "Check out this cool picture!"
        
        let itmesToShare = [textToShare, self.profileImageView.image as Any] as [Any]
        let activityVC = UIActivityViewController(activityItems: itmesToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = (sender as? UIView)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    //MARK: My Functions
    func updateViews() {
        guard let photo = photo else { return }
        PhotoController.sharedController.fetchCameraInfoFor(photo) { (cameraString) in
            DispatchQueue.main.async {
                self.cameraLabel.text = cameraString
            }
        }
        PhotoController.sharedController.fetchImageFor(photo, size: .Large) { (largeImage) in
            self.photoImageView.image = largeImage
        }
        UserController.sharedController.fetchUserDataFor(photo.ownerID) { (user) in
            guard let user = user else { return }
            UserController.sharedController.fetchProfileImageFor(user, completion: { (profileImage) in
                DispatchQueue.main.async {
                    self.profileImageView.image = profileImage
                }
            })
        }
        self.usernameLabel.text = self.photo?.ownerName
        self.titleLabel.text = self.photo?.title
        
        self.profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        self.profileImageView.clipsToBounds = true
    }
}
