//
//  ThumbnailImgParse.swift
//  nftjam
//
//  Created by Daniel Jones on 4/1/22.
//

import Foundation
import Parse

class ThumbnailImgParse: SuperParseObject, PFSubclassing {
    @NSManaged var img: PFFileObject
    
    class func parseClassName() -> String {
        return "ThumbnailImg"
    }
}
