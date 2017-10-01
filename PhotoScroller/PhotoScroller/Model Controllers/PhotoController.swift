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
    //Example Endpoint: https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&format=json&api_key=95120ae5940c9318841e1c9b86243299&group_id=80641914@N00
    
    private let idKey = "id"
    private let ownerIDKey = "owner"
    private let titleKey = "title"
    private let ownerNameKey = "ownername"
    
    let id: String
    let ownerID: String
    let title: String
    let ownerName: String
    
//    init(id: String, ownerID: String, title: String, ownerName: String) {
//        self.id = id
//        self.ownerID = ownerID
//        self.title = title
//        self.ownerName = ownerName
//    }
    
    //Failable Initializer
    init?(dictionary: [String:String]) {
        guard let id = dictionary[idKey],
            let ownerID = dictionary[ownerIDKey],
            let title = dictionary[titleKey],
            let ownerName = dictionary[ownerNameKey]
            else { return nil }
        
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.ownerName = ownerName
    }
    
}
