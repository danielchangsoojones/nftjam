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
                                         "montageID": youtubeUpload.montage.objectId ?? ""
        ]
        PFCloud.callFunction(inBackground: "uploadNFT", withParameters: parameters) { (result, error) in
            let isSuccess = result != nil
            completion(isSuccess, error)
        }
    }
}
