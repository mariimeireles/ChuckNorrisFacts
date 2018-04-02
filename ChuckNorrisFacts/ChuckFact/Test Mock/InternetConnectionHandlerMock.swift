//
//  InternetConnectionHandlerMock.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 02/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class InternetConnectionHandlerMock: InternetConnectionHandler {
    
    func verify(_ error: Error) throws {
        guard let urlError = error as? URLError.Code else {
            throw error
        }
        if urlError == .notConnectedToInternet {
            throw ServiceError.connection(.noConnection)
        }
        else if urlError == .timedOut {
            throw ServiceError.connection(.timeout)
        }
        else {
            throw ServiceError.connection(.other)
        }
    }
}
