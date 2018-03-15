//
//  FactWebServiceProtocol.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 15/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation
import RxSwift

protocol FactServiceProtocol: class {
    
    func getFacts(_ term: String) -> Observable<[Fact]>
}

