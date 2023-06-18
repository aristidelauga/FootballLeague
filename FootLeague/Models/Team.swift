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


struct Team: Codable {
  var idTeam: String?
  var strTeam, strTeamShort, strAlternate: String?
  var strLeague, idLeague: String?
  var strDescriptionFR: String?
  var strCountry: String?
  var strTeamBadge: String?
  var strTeamBanner: String?
}
