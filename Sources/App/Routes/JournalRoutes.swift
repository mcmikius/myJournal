//
//  JournalRoutes.swift
//  App
//
//  Created by Mykhailo Bondarenko on 30.03.2020.
//

import Vapor

struct JournalRoutes: RouteCollection {
    
    let journal = JournalController()
    
    func boot(router: Router) throws {
        // to be implemented later
    }
    // Add route handlers here
}
