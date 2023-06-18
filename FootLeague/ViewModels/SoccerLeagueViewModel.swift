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
  @Published var urlComponents: URLComponents
  
  init() {
    selectedTeam = Team(idTeam: "", strTeam: "", strTeamShort: "", strAlternate: "", strLeague: "", idLeague: "", strDescriptionFR: "", strCountry: "", strTeamBadge: "", strTeamBanner: "")
    var components = URLComponents()
    components.scheme = "https"
    components.host = "thesportsdb.com"
    components.path = "/api/v1/json/50130162/all_leagues.php"
    urlComponents = components
  }
  
  enum FetchingError: String, Error {
    case badURL = "Bad URL"
    case decoderError = "Error decoding the datas"
  }
  
  func load<T: Codable>(from components: URLComponents, type: T.Type) async throws -> T {
    
    guard let soccerUrl = components.url else {
      fatalError("Could not create URL from components")
    }
    let (data, response) = try await URLSession.shared.data(from: soccerUrl)
    guard
      let httpResponse = response as? HTTPURLResponse,
      httpResponse.statusCode == 200 else {
      fatalError("Issue with the URL")
    }
    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
      fatalError("Issue decoding the data")
      
    }
    return decodedResponse
  }
  
  
}


/*
 
 https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=French%20Ligue%201
 
 /*
  
  https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php
  
  */
 //  func load<T: Codable>(from: String, withSpecification: String?, type: T.Type) async throws -> T {

 
 //    let (data, response) = try await URLSession.shared.data(from: URL(string: url) ?? URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=French%20Ligue%201")!)
 //    let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
 
 
 
 //      throw FetchingError.decoderError

 */
