//
//  DiscoverDataStore.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import Foundation
import Parse
import SwiftyJSON

class MontageData {
    let montage: MontageParse
    let photos: [MontagePhotoParse]
    
    init(montage: MontageParse, photos: [MontagePhotoParse]) {
        self.montage = montage
        self.photos = photos
    }
}

class DiscoverDataStore {
    func loadPhotos(completion: @escaping ([MontageData]) -> Void) {
        let parameters: [String: Any] = [:]
        PFCloud.callFunction(inBackground: "loadDiscoverMontagePhotos", withParameters: parameters) { (results, error) in
            if let results = results {
                let montageDatas = self.parse(results)
                completion(montageDatas)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadDiscoverMontagePhotos")
            }
        }
    }
    
    private func parse(_ results: Any) -> [MontageData] {
        let json = JSON(results)
        let jsonArray = json.arrayValue
        var montageDatas: [MontageData] = []
        
        for element in jsonArray {
            if let dictElement = element.dictionaryObject {
                let montage = dictElement["montage"] as? MontageParse
                let montagePhotos = dictElement["montagePhotos"] as? [MontagePhotoParse]
                if let montage = montage, let montagePhotos = montagePhotos {
                    let montageData = MontageData(montage: montage, photos: montagePhotos)
                    montageDatas.append(montageData)
                }
            }
        }
        
        return montageDatas
    }
}
