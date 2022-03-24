//
//  MessageParse.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Parse

class NFTVideoParse: SuperParseObject, PFSubclassing {
    @NSManaged var thumbnailImg: PFFileObject?
    
    class func parseClassName() -> String {
        return "NFTVideo"
    }
}
