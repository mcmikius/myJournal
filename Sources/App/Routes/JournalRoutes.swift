//
//  JournalRoutes.swift
//  App
//
//  Created by Mykhailo Bondarenko on 30.03.2020.
//

import Vapor
import Leaf

struct JournalRoutes: RouteCollection {
    
    let title = "My Journal"
    let author = "Angus"
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
    
    func getTotal(_ req: Request) throws -> Future<View> {
        let total = journal.total()
        let count = "\(total)"
        let leaf = try req.make(LeafRenderer.self)
        let context = ["title": title, "author": author, "count": count]
        return leaf.render("main", context)
    }
    
    func newEntry(_ req: Request) throws -> Future<HTTPStatus> {
        let newID = UUID().uuidString
        return try req.content.decode(Entry.self).map(to: HTTPStatus.self, { (entry) in
            let newEntry = Entry(id: newID, title: entry.title, content: entry.content)
            guard let result = self.journal.create(newEntry) else {
                throw Abort(.badRequest)
            }
            print("Created: \(result)")
            return .ok
        })
    }
    
    func getEntry(_ req: Request) throws -> Entry {
        let index = try req.parameters.next(Int.self)
        let res = req.response()
        guard let entry = journal.read(index: index) else {
            throw Abort(.badRequest)
        }
        print("Read: \(entry)")
        try res.content.encode(entry, as: .formData)
        return entry
    }
    
    func editEntry(_ req: Request) throws -> Future<HTTPStatus> {
        let index = try req.parameters.next(Int.self)
        let newID = UUID().uuidString
        return try req.content.decode(Entry.self).map(to: HTTPStatus.self) { entry in
            let newEntry = Entry(id: newID, title: entry.title, content: entry.content)
            guard let result = self.journal.update(index: index, entry: newEntry) else {
                throw Abort(.badRequest)
            }
            print("Updated: \(result)")
            return .ok
        }
    }
    
    func removeEntry(_ req: Request) throws -> HTTPStatus {
        let index = try req.parameters.next(Int.self)
        guard let result = self.journal.delete(index: index) else {
            throw Abort(.badRequest)
        }
        print("Deleted: \(result)")
        return .ok
    }
    
    
}
