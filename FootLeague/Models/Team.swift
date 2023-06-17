//
//  Team.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 16/06/2023.
//

import Foundation

struct LeagueTeams: Codable {
  let teams: [Team]
}


//struct Team: Codable {
//  let idTeam, strTeam, strTeamShort: String?
//  let strAlternate: String?
//  let strLeague, idLeague : String?
////  let strLeague2, idLeague2, strLeague3, idLeague3, strLeague4, idLeague4, strLeague5, idLeague5, strLeague6, idLeague6, strLeague7, idLeague7: String
//  let strDescriptionFR: String?
//  let strTeamBanner: String?
//}

struct Team: Codable {
  let idTeam: String?
  let strTeam, strTeamShort, strAlternate: String?
  let strLeague, idLeague: String?
  let strDescriptionFR: String?
  let strTeamBanner: String?
}
