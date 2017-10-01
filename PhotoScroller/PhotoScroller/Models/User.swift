//
//  User.swift
//  PhotoScroller
//
//  Created by Work on 10/1/17.
//  Copyright © 2017 D Miller Consulting. All rights reserved.
//

import Foundation

class User {
    
    private let nsidKey = "nsid"
    
    let nsid: String
    
    init?(dictionary: [String:String]) {
        guard let nsid = dictionary[nsidKey] else { return nil }
        self.nsid = nsid
    }
}
