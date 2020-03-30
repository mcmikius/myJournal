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
        let topRouter = router.grouped("journal")
        topRouter.get(use: getEntry)
        topRouter.post(use: newEntry)
        
        let entryRouter = router.grouped("journal", Int.parameter)
        entryRouter.get(use: getEntry)
        entryRouter.put(use: editEntry)
        entryRouter.delete(use: removeEntry)
    }
    
    func getTotal(_ req: Request) -> String {
        let total = journal.total()
        print("Total Records: \(total)")
        return "\(total)"
    }
}
