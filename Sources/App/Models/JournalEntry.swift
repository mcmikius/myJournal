//
//  JournalEntry.swift
//  App
//
//  Created by Mykhailo Bondarenko on 30.03.2020.
//

import FluentPostgreSQL
import Vapor

final class JournalEntry: PostgreSQLModel {
    typealias Database = PostgreSQLDatabase
    var id: Int?
    var title: String
    var content: String
    
    init(id: Int? = nil, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}

extension JournalEntry: Migration {}
extension JournalEntry: Content {}
extension JournalEntry: Parameter {}
