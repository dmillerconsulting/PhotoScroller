//
//  TopPhotosCollectionViewController.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class TopPhotosCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: IBActions
    @IBAction func searchButonTapped(_ sender: Any) {
        if searchField.text != "", let searchText = searchField.text, self.searchButton.titleLabel?.text == "Search"{
            UserController.sharedController.searchForUserWith(username: searchText) { (user) in
                guard let user = user else {
                    DispatchQueue.main.async {
                        self.displayAlertController()
                        self.searchField.text = ""
                    };
                    return }
                PhotoController.sharedController.fetchPhotosBy(user, completion: { (photos) in
                    guard let photos = photos else { return }
                    self.photos = photos
                    DispatchQueue.main.async {
                        self.searchButton.titleLabel?.text = "Clear"
                    }
                })
            }
        } else if self.searchButton.titleLabel?.text == "Clear"{
            DispatchQueue.main.async {
                self.searchButton.titleLabel?.text = "Search"
                self.searchField.text = ""
                self.loadTopPhotos()
            }
        }
    }
    
    func displayAlertController() {
        let alertController = UIAlertController(title: "Could Not Find User", message: "The user you searched for was not found", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func searchFieldValueChanged(_ sender: Any) {
        if searchField.text != "" {
            searchButton.isEnabled = true
        }
    }
    
    @IBAction func searchFieldEditingDidBegin(_ sender: Any) {
        if searchField.text != "" {
            DispatchQueue.main.async{
                self.searchButton.isEnabled = true
            }
        }
    }
    
    
    var photos: [Photo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = "Top Photos"
        
        loadTopPhotos()
    }
    
    func loadTopPhotos() {
        PhotoController.sharedController.fetchTopPhotos { (photos) in
            guard let photos = photos else { return }
            self.photos = photos
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? PhotoDetailViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first
                else { return }
            
            destinationVC.photo = photos[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailVC", sender: self)
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = self.photos[indexPath.row]
        cell.photo = photo
    
        return cell
    }
    
    //Remove image from each cell as it dequeues
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return }
        
        cell.photo = Photo(id: "...", ownerID: "...", title: "...", ownerName: "...", secret: "...", farm: 0, server: "...")
        cell.photoImageView.image = #imageLiteral(resourceName: "placeholder")
    }
}
