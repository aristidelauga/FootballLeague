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
  var strDescriptionEN: String?
  var strDescriptionFR: String?
  var strCountry: String?
  var strTeamBadge: String?
  var strTeamBanner: String?
  
  var description: String {
    switch strCountry {
      case "England", "Germany", "China", "Italy", "Japan", "Russia", "Spain", "Portugal", "Sweden", "Netherlands", "Hungary", "Norway", "Israel", "Poland":
      return strDescriptionEN ?? "No description available"
      case "France":
        return strDescriptionFR ?? "Pas de description disponible"
      default:
        return strDescriptionFR ?? "No description available"
    }
  }
}
