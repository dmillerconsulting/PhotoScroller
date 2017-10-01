//
//  Image.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import Foundation

class Photo {
    //Example Endpoint: https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&format=json&api_key=95120ae5940c9318841e1c9b86243299&group_id=80641914@N00
    
    //MARK: Dictionary Keys
    private let idKey = "id"
    private let ownerIDKey = "owner"
    private let titleKey = "title"
    private let ownerNameKey = "ownername"
    private let secretKey = "secret"
    private let farmKey = "farm"
    private let serverKey = "server"
    
    //MARK: Properties
    let id: String
    let ownerID: String
    let title: String
    let ownerName: String
    let secret: String
    let farm: Int
    let server: String
    
    //    init(id: String, ownerID: String, title: String, ownerName: String) {
    //        self.id = id
    //        self.ownerID = ownerID
    //        self.title = title
    //        self.ownerName = ownerName
    //    }
    
    //MARK: Failable Initializer
    init?(dictionary: [String:Any]) {
        guard let id = dictionary[idKey] as? String,
            let ownerID = dictionary[ownerIDKey] as? String,
            let title = dictionary[titleKey] as? String,
            let ownerName = dictionary[ownerNameKey] as? String,
            let secret = dictionary[secretKey] as? String,
            let farm = dictionary[farmKey] as? Int,
            let server = dictionary[serverKey] as? String
            else { return nil }
        
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.ownerName = ownerName
        self.secret = secret
        self.farm = farm
        self.server = server
    }
}
