//
//  MontagePhotoParse.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import UIKit
import Parse

class MontagePhotoParse: SuperParseObject, PFSubclassing {
    @NSManaged var image: PFFileObject?
    @NSManaged var montage: MontageParse
    
    class func parseClassName() -> String {
        return "MontagePhotoParse"
    }
}


