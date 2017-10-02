//
//  PhotoCollectionViewCell.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photo: Photo? {
        didSet {
            self.updateViews()
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Actions
    
    //MARK: Functions
    func updateViews() {
        DispatchQueue.main.async {
            guard let photo = self.photo else { return }
            self.usernameLabel.text = photo.ownerName
            self.titleLabel.text = photo.title
            PhotoController.sharedController.fetchImageFor(photo, size: .Small, completion: { (image) in
                self.photoImageView.image = image
            })
        }
    }
}
