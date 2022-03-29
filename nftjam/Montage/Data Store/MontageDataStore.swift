//
//  MontageDataStore.swift
//  nftjam
//
//  Created by Daniel Jones on 3/24/22.
//

import Foundation
import Parse

class MontageDataStore {
    func loadMontage(with montageID: String, completion: @escaping (Any?, Error?) -> Void) {
        let parameters: [String: Any] = [
            "montageID": montageID
        ]
        PFCloud.callFunction(inBackground: "loadMontage", withParameters: parameters) { (result, error) in
            completion(result, error)
        }
    }
}
