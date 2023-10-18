//
//  APIResults.swift
//  ApprendreAPI
//
//  Created by Alain Deblois on 2023-10-14.
//

import Foundation

struct Tournament: Decodable {
    var TournamentID: Int
    var Name: String
    var StartDate: String
    var EndDate: String
    var IsOver: Bool
    var IsInProgress: Bool
    var Venue: String
    var Location: String?
    var Par: Int?
    var Yards: Int?
    var Purse: Decimal?
    var StartDateTime: String?
    var Canceled: Bool
    var Covered: Bool
    var City: String?
}

struct LeaderBoard: Decodable {
    var Tournament: Tournament
    var Players: [Players]
}

struct Players: Decodable {
    var PlayerTournamentID: Int?
    var PlayerID: Int?
    var TournamentID: Int?
    var Name: String?
    var Rank: Int?
    var Country: String?
    var TotalScore: Double?
    var TotalStrokes: Double?
    var TotalThrough: Int?
    var Earnings: Double?
}

struct Player: Decodable {
    var PlayerID: Int = 0
    var FirstName: String
    var LastName: String
    var PhotoUrl: String?
    
}



