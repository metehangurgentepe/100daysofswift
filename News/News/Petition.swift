//
//  Petition.swift
//  News
//
//  Created by Metehan Gürgentepe on 22.08.2024.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
