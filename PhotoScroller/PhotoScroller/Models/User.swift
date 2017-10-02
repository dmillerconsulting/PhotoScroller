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
    private let iconServerKey = "iconserver"
    private let iconFarmKey = "iconfarm"
    
    let nsid: String
    let iconServer: String
    let iconFarm: Int
    
    init?(dictionary: [String:Any]) {
        guard let nsid = dictionary[nsidKey] as? String,
            let iconServer = dictionary[iconServerKey] as? String,
            let iconFarm = dictionary[iconFarmKey] as? Int
        else { return nil }
        
        self.nsid = nsid
        self.iconServer = iconServer
        self.iconFarm = iconFarm
    }
}
