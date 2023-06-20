//
//  SoccerLeagueViewModel.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 16/06/2023.
//

import Foundation

class SoccerLeagueViewModel: ObservableObject {
  @Published var allLeagues = [League]()
  @Published var teams = [Team]()
  @Published var selectedTeam: Team
  @Published var urlComponents: URLComponents = URLComponents.league
  
  init() {
    selectedTeam = Team(idTeam: "", strTeam: "", strTeamShort: "", strAlternate: "", strLeague: "", idLeague: "", strDescriptionFR: "", strCountry: "", strTeamBadge: "", strTeamBanner: "")
  }
  
  enum FetchingError: String, Error {
    case badURL = "Bad URL"
    case decodingError = "Error decoding the datas"
  }
  
  func load<T: Codable>(from components: URLComponents, type: T.Type) async throws -> T {
    
    guard let soccerUrl = components.url else {
      fatalError("Could not create URL from components")
    }
    let (data, response) = try await URLSession.shared.data(from: soccerUrl)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw FetchingError.badURL
    }
    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
      throw FetchingError.decodingError
      
    }
    return decodedResponse
  }
  
  
  func filteredTeams(_ teams: [Team]) -> [Team] {
    var filteredTeams: [Team] = []
    for index in 0..<teams.count {
      if (index % 2) == 0 {
        filteredTeams.append(teams[index])
      }
    }
    return filteredTeams
  }
}
