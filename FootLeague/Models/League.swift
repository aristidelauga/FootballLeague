//
//  League.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 16/06/2023.
//

import Foundation
//
struct SoccerLeague: Codable {
  let leagues: [League]
}

struct League: Codable {
  let idLeague: String
  let strLeague: String
  let strSport: String
  let strLeagueAlternate: String?
}

/*
 
 {"idLeague":"4328","strLeague":"English Premier League","strSport":"Soccer","strLeagueAlternate":"Premier League, EPL"}
 
 */
