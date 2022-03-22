//
//  Enviroment.swift
//  lookbook
//
//  Created by Daniel Jones on 2/7/22.
//

import Foundation

public enum Environment: String {
    case development = "Development"
    case production = "Production"
    
    var appID: String {
        switch self {
        case .development:
            return "nftjamdevelopment206093030"
        case .production:
            return ""
        }
    }
    
    var serverURL: String {
        switch self {
        case .development:
            return "https://nft-jam-development.herokuapp.com/parse"
        case .production:
            return ""
        }
    }
}

class Configuration {
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Development") != nil {
                return .development
            }
        }
        
        return .production
    }()
}
