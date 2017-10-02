//
//  PhotoController.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import Foundation
import UIKit

class PhotoController {
    static let sharedController = PhotoController()
    //Example Endpoint: https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&format=json&api_key=95120ae5940c9318841e1c9b86243299&group_id=80641914@N00
    let baseURL = URL(string: "https://api.flickr.com/services/rest/?")
    
    enum imageSize: String {
        case Small = "n"
        case Large = "k"
    }
    
    //CRUD Functions
    
    // Pull basic photo data from Flickr top photos
    func fetchTopPhotos(completion: @escaping ([Photo]?) -> Void) {
        guard let baseURL = baseURL else { return }
        let urlParameters = ["format":"json",
                             "method":"flickr.groups.pools.getPhotos",
                             "api_key":NetworkController.apiKey,
                             "group_id":"80641914@N00",
                             "nojsoncallback":"1"]
        NetworkController.performRequest(for: baseURL, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error with request")
            }
            
            guard let data = data,
                let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any],
                let photosDictionary = jsonDictionary["photos"] as? [String:Any],
                let photoDictionaryArray = photosDictionary["photo"] as? [[String:Any]]
            else { return }
            
            let photosArray = photoDictionaryArray.flatMap({ Photo.init(dictionary: $0) })
            completion(photosArray)
        }
    }
    
    //Fetch larger image
    func fetchImageFor(_ photo: Photo, size: imageSize, completion: @escaping (UIImage?) -> Void) {
        //Example endpoint: https://farm5.staticflickr.com/4379/36941145645_f1de3df2d7_n.jpg
        
        let url = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_\(size.rawValue).jpg"
        
        ImageController.image(forURL: url) { (image) in
            guard let image = image else { return }
            completion(image)
        }
    }
}
