//
//  Model.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 02.12.2023.
//

import Foundation
import UIKit

class Venue: Codable {
    let title: String?
    let location: Location
    let contact: Contact?
    let description: String?
    let photo_url: String?
    let rating: Double?
    let types_games: [TypesGame]?
    let feed_backs: [FeedBack]?

    enum CodingKeys: String, CodingKey {
        case title, location, contact, description
        case photo_url
        case rating
        case types_games
        case feed_backs
    }

    init(title: String, location: Location, contact: Contact, description: String?, photoURL: String?, rating: Double, typesGames: [TypesGame]?, feedBacks: [FeedBack]) {
        self.title = title
        self.location = location
        self.contact = contact
        self.description = description
        self.photo_url = photoURL
        self.rating = rating
        self.types_games = typesGames
        self.feed_backs = feedBacks
    }
}

class Contact: Codable {
    let phone: String?
    let site: String?

    init(phone: String?, site: String?) {
        self.phone = phone
        self.site = site
    }
}

class FeedBack: Codable {
    let nickname: String?
    let text: Text?
    let mark: Double?

    init(nickname: String, text: Text, mark: Double) {
        self.nickname = nickname
        self.text = text
        self.mark = mark
    }
}

class Text: Codable {
    let pros, cons: String?

    init(pros: String, cons: String) {
        self.pros = pros
        self.cons = cons
    }
}

class Location: Codable {
    let city, country: String
    let address: String?
    
    init(city: String, country: String, address: String) {
        self.city = city
        self.country = country
        self.address = address
    }
}

enum TypesGame: String, Codable {
    case baccarat = "Baccarat"
    case betting = "Betting"
    case bingo = "Bingo"
    case blackJack = "BlackJack"
    case craps = "Craps"
    case electronicTables = "Electronic Tables"
    case otherGames = "Other Games"
    case poker = "Poker"
    case roulette = "Roulette"
    case slotMachines = "Slot Machines"
}

class News {
    
    var title = ""
    var description = ""
    var image = UIImage()
    var daysAgo = ""
    
    init(title: String = "", description: String = "", image: UIImage = UIImage(), daysAgo: String = "") {
        self.title = title
        self.description = description
        self.image = image
        self.daysAgo = daysAgo
    }
    
}

class CasinoModel {
    
    static let shared = CasinoModel()
    
    private init() {}

    var casinosArray: [Venue] = []
    
    var imagesArray: [UIImage] = []
    
}

struct Region {
    var country: String
    var cities: [String]
    var isExpanded: Bool
}
