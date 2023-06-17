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

