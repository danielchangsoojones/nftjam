//
//  MontageParse.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import Foundation
import Parse

class MontageParse: SuperParseObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var creator: User
    @NSManaged var valueLocked: Double
    @NSManaged var ethAddressQR: PFFileObject
    @NSManaged var ethAddressStr: String
    @NSManaged var mintPrice: Double
    
    class func parseClassName() -> String {
        return "Montage"
    }
}
