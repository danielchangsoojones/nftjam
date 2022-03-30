//
//  DiscoverDataStore.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import Foundation
import Parse

class MontageDatas {
    let montage: MontageParse
    let photos: [MontagePhotoParse]
    
    init(montage: MontageParse, photos: [MontagePhotoParse]) {
        self.montage = montage
        self.photos = photos
    }
}

class DiscoverDataStore {
    func loadPhotos(completion: @escaping ([MontageDatas]) -> Void) {
        let parameters: [String: Any] = [:]
        PFCloud.callFunction(inBackground: "loadDiscoverMontagePhotos", withParameters: parameters) { (results, error) in
            if let results = results {
                completion(montageDatas)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadDiscoverMontagePhotos")
            }
        }
    }
}
