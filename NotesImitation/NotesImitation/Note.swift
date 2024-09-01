//
//  Note.swift
//  NotesImitation
//
//  Created by Metehan Gürgentepe on 28.08.2024.
//

import Foundation

struct Note: Codable {
    var id: String
    var text: String
    var date: Date
    var title: String
    
    init(id: String? = nil, text: String, date: Date, title: String? = nil) {
        self.id = UUID().uuidString
        self.text = text
        self.date = date
        self.title = String(text.prefix(15))
    }
}
