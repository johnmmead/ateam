//
//  Team.swift
//  ateam
//
//  Created by Feng Jiao on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

import Foundation

class Team: NSObject {
    var name: String
    var info: String
    var url: String
    var deviceId: String
    var members = [Person]()

    init(name: String, info: String, url: String, deviceId: String){
        self.name = name
        self.info = info
        self.url = url
        self.deviceId = deviceId
    }
}