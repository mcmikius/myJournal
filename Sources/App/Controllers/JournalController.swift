//
//  JournalController.swift
//  App
//
//  Created by Mykhailo Bondarenko on 30.03.2020.
//

import Vapor

final class JournalController {
    
    var entries : Array<Entry> = Array()
    
    //: Get total number of entries
    func total() -> Int {
        return entries.count
    }
    //: Create a new journal entry
    func create(_ entry: Entry) -> Entry? {
        entries.append(entry)
        return entries.last
    }
    //: Read a journal entry
    func read(index: Int) -> Entry? {
        if let entry = entries.get(index: index) {
            return entry
        }
        return nil
    }
    //: Read all journal entries
    func readAll() -> [Entry] {
        return entries
    }
    //: Update the journal entry
    func update(index: Int, entry: Entry) -> Entry? {
        if let entry = entries.get(index: index) {
            entries[index] = entry
            return entry
        }
        return nil
    }
    //: Delete a journal entry
    func delete(index: Int) -> Entry? {
        if let _ = entries.get(index: index) {
            return entries.remove(at: index)
        }
        return nil
    }
}

extension Array {
    func get(index: Int) -> Element? {
        if index >= 0 && index < count {
            return self[index]
        }
        return nil
    }
}
