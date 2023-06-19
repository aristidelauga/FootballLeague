//
//  URL.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 17/06/2023.
//

import Foundation


enum URLFromAPI: String {
  case leagues = "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php"
  case teams = "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l="
  case selectedTeam = "https://www.thesportsdb.com/api/v1/json/50130162/searchteams.php?t"
}

extension URLComponents {
  static var league: URLComponents {
    var leagueComponents = URLComponents()
    leagueComponents.scheme = "https"
    leagueComponents.host = "thesportsdb.com"
    leagueComponents.path = "/api/v1/json/50130162/all_leagues.php"
    return leagueComponents
  }
  static var teams: URLComponents {
    var teamsComponents = URLComponents()
    teamsComponents.scheme = "https"
    teamsComponents.host = "thesportsdb.com"
    teamsComponents.path = "/api/v1/json/50130162/search_all_teams.php"
    return teamsComponents
    
  }
  static var selectedTeam: URLComponents {
    var selectedTeamComponents = URLComponents()
    selectedTeamComponents.scheme = "https"
    selectedTeamComponents.host = "thesportsdb.com"
    selectedTeamComponents.path = "/api/v1/json/50130162/searchteams.php"
    return selectedTeamComponents
  }
}
