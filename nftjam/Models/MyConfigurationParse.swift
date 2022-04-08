//
//  ConfigurationParse.swift
//  nftjam
//
//  Created by Daniel Jones on 4/7/22.
//

import Foundation
import Parse

class MyConfigurationParse: SuperParseObject, PFSubclassing {
    static var shared: MyConfigurationParse?
    
    @NSManaged var isHiding: Bool
    
    class func parseClassName() -> String {
        return "MyConfiguration"
    }
}
