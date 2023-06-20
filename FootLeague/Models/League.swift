//
//  League.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 16/06/2023.
//

import Foundation

struct SoccerLeague: Codable {
  let leagues: [League]
}

struct League: Codable, Identifiable, Hashable {
  var id: String { return idLeague }
  let idLeague: String
  let strLeague: String
  let strSport: String
  let strLeagueAlternate: String?
}
