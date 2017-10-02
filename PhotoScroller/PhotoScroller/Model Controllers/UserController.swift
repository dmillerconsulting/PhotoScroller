//
//  UserController.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import Foundation
import UIKit

class UserController {
    
    static let sharedController = UserController()
    
    //Get necessary data to get a user's profile image URL
    func fetchUserDataFor(_ userID: String, completion: @escaping (User?) -> Void) {
        //Example Endpoint: https://api.flickr.com/services/rest/?method=flickr.people.getInfo&format=json&api_key=95120ae5940c9318841e1c9b86243299&user_id=130399872@N03&nojsoncallback=1
        
        guard let baseURL = URL(string: "https://api.flickr.com/services/rest/?") else { return }
        let urlParameters = ["method":"flickr.people.getInfo",
                             "format":"json",
                             "api_key":NetworkController.apiKey,
                             "user_id":userID,
                             "nojsoncallback":"1"]
        
        NetworkController.performRequest(for: baseURL, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error with user data request")
            }
            
            guard let data = data,
                let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any],
                let personDictionary = jsonDictionary["person"] as? [String:Any],
                let user = User(dictionary: personDictionary)
                else { return }
            
            completion(user)
        }
    }
    
    func fetchProfileImageFor(_ user: User, completion: @escaping (UIImage?) -> Void) {
        //Example Endpoint: http://farm8.staticflickr.com/5659/buddyicons/130399872@N03.jpg
        let imageURL = "http://farm\(user.iconFarm).staticflickr.com/\(user.iconServer)/buddyicons/\(user.nsid).jpg"
        
        ImageController.image(forURL: imageURL) { (profileImage) in
            guard let profilImage = profileImage else { return }
            completion(profilImage)
        }
    }
    
    // Get user data from a username
    func searchForUserWith(username: String, completion: @escaping (User?) -> Void) {
        //Example Endpoint: https://api.flickr.com/services/rest/?method=flickr.people.findByUsername&format=json&api_key=95120ae5940c9318841e1c9b86243299&username=davidmillerphotography&nojsoncallback=1
        
        guard let baseURL = URL(string: "https://api.flickr.com/services/rest/?") else { return }
        let urlParameters = ["method":"flickr.people.findByUsername",
                             "format":"json",
                             "api_key":NetworkController.apiKey,
                             "username":username,
                             "nojsoncallback":"1"]
        NetworkController.performRequest(for: baseURL, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error with user data request")
            }
            
            guard let data = data,
                let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any],
                let userDictionary = jsonDictionary["user"] as? [String:Any],
                let userID = userDictionary["id"] as? String
                else { completion(nil); return }
            
            self.fetchUserDataFor(userID, completion: { (user) in
                guard let user = user else { return }
                completion(user)
            })
        }
    }
}
