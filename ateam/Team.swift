//
//  Team.swift
//  ateam
//
//  Created by Feng Jiao on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

import Foundation

class Team: NSObject {
    var Name: String
    var Info: String
    var Url: String
    init(name: String, info: String, url: String){
        Name=name
        Info=info
        Url=url
    }
}