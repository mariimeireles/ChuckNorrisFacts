//
//  InternetConnectionHandler.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class InternetConnectionHandler {
    
    func verifyConnection(_ error: Error) throws {
        guard let urlError = error as? URLError else { throw error }
        
        if urlError.code == .notConnectedToInternet {
            throw ServiceError.connection(.noConnection)
        }
        if urlError.code == .timedOut {
            throw ServiceError.connection(.timeout)
        } else {
            throw ServiceError.connection(.other)
        }
    }
}
