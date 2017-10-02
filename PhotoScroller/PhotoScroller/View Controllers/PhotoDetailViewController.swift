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
    
    func updateViews() {
        guard let photo = photo else { return }
        PhotoController.sharedController.fetchCameraInfoFor(photo) { (cameraString) in
            self.cameraLabel.text = cameraString
        }
        PhotoController.sharedController.fetchImageFor(photo, size: .Large) { (largeImage) in
            self.photoImageView.image = largeImage
        }
        self.usernameLabel.text = self.photo?.ownerName
        self.titleLabel.text = self.photo?.title
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
