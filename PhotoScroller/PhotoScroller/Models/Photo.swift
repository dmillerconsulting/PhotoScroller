//
//  Image.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import Foundation

class Photo {
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
    var ownerName: String = ""
    let secret: String
    let farm: Int
    let server: String
    
    init(id: String, ownerID: String, title: String, ownerName: String, secret: String, farm: Int, server: String) {
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.ownerName = ownerName
        self.secret = secret
        self.farm = farm
        self.server = server
    }
    
    //MARK: Failable Initializer for top photos
    init?(topPhotosDictionary: [String:Any]) {
        guard let id = topPhotosDictionary[idKey] as? String,
            let ownerID = topPhotosDictionary[ownerIDKey] as? String,
            let title = topPhotosDictionary[titleKey] as? String,
            let ownerName = topPhotosDictionary[ownerNameKey] as? String,
            let secret = topPhotosDictionary[secretKey] as? String,
            let farm = topPhotosDictionary[farmKey] as? Int,
            let server = topPhotosDictionary[serverKey] as? String
            else { return nil }
        
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.ownerName = ownerName
        self.secret = secret
        self.farm = farm
        self.server = server
    }
    
    init?(userPhotosDictionary: [String:Any]) {
        guard let id = userPhotosDictionary[idKey] as? String,
            let ownerID = userPhotosDictionary[ownerIDKey] as? String,
            let title = userPhotosDictionary[titleKey] as? String,
            let secret = userPhotosDictionary[secretKey] as? String,
            let farm = userPhotosDictionary[farmKey] as? Int,
            let server = userPhotosDictionary[serverKey] as? String
            else { return nil }
        
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.secret = secret
        self.farm = farm
        self.server = server
    }
}
