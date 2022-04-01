//
//  User.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import Parse

class User: PFUser {
    @NSManaged var name: String?
    @NSManaged var phoneNumber: Double
    @NSManaged var deviceType: String?
    @NSManaged var codeName: String
}
