//
//  UploadDataStore.swift
//  nftjam
//
//  Created by Daniel Jones on 3/22/22.
//

import UIKit
import Parse

class UploadDataStore {
    func uploadNFTLink(youtubeUpload: YoutubeUpload, completion: @escaping (Bool, Error?) -> Void) {
        let parameters: [String: Any] = ["startTimeSeconds": youtubeUpload.startTimeSeconds,
                                         "endTimeSeconds": youtubeUpload.endTimeSeconds,
                                         "youtubeID": youtubeUpload.youtubeID,
                                         "mediaLink": youtubeUpload.mediaLink,
                                         "ethAddress": youtubeUpload.ethAddress,
                                         "priceToMint": youtubeUpload.priceToMint,
                                         "montageID": youtubeUpload.montage.objectId ?? "",
                                         "purchaseMedium": youtubeUpload.purchaseMedium
        ]
        PFCloud.callFunction(inBackground: "uploadNFT", withParameters: parameters) { (result, error) in
            let isSuccess = result != nil
            completion(isSuccess, error)
        }
    }
    
    func getYoutubeThumbnail(for youtubeID: String, completion: @escaping (ThumbnailImgParse?, Error?) -> Void) {
        let parameters: [String: Any] = ["youtubeID": youtubeID]
        PFCloud.callFunction(inBackground: "getThumbnailImage", withParameters: parameters) { (result, error) in
            if let thumbnail = result as? ThumbnailImgParse {
                completion(thumbnail, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
