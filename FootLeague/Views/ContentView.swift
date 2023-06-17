//
//  ContentView.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 16/06/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var soccerLeagueViewModel = SoccerLeagueViewModel()
  @State private var searchText = ""
  @Environment(\.isSearching)
  private var isSearching: Bool
  let columns = [
    GridItem(.fixed(UIScreen.main.bounds.width / 2), spacing: 5),
    GridItem(.fixed(UIScreen.main.bounds.width / 2), spacing: 5),
  ]
  var body: some View {
    NavigationStack {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVGrid(columns: columns, alignment: .center) {
          ForEach(soccerLeagueViewModel.teams, id: \.idTeam) { team in
            VStack {
              AsyncImage(url: URL(string: team.strTeamBanner ?? "https://www.thesportsdb.com/images/media/team/fanart/oybkzq1607720313.jpg")!) { image in
                image.resizable()
                  .frame(maxWidth: 180, maxHeight: 360)
                  .aspectRatio(contentMode: .fill)
              } placeholder: {
                ProgressView()
              }
              .frame(maxWidth: 180, maxHeight: 360)
              Text(team.strTeam ?? "")
            }
            
          }
          //          .overlay {
          //            if isSearching && !searchText.isEmpty {
          //              VStack {
          //                ForEach(soccerLeagueViewModel.allLeagues, id: \.idLeague) { suggestion in
          //                  Text(suggestion.strLeague)
          //                    .searchCompletion(suggestion.strLeague)
          //                }
          //              }
          //              .background(Color.gray)
          //            }
          //          }
        }
      }
      //      .onAppear {
      //        Task {
      //          soccerLeagueViewModel.allLeagues = try! await soccerLeagueViewModel.load(from: URLFromAPI.leagues.rawValue, withSpecification: "", type: SoccerLeague.self).leagues
      //        }
      //      }
    }
    .searchable(text: $searchText, prompt: "Search by league", suggestions: {
      ForEach(soccerLeagueViewModel.allLeagues, id: \.idLeague) { suggestion in
        Text(suggestion.strLeague)
          .searchCompletion(suggestion.strLeague)
      }
    })
    .onSubmit(of: .search) {
      soccerLeagueViewModel.urlComponents.scheme = "https"
      soccerLeagueViewModel.urlComponents.host = "thesportsdb.com"
      soccerLeagueViewModel.urlComponents.path = "/api/v1/json/50130162/search_all_teams.php"
//      soccerLeagueViewModel.urlComponents.queryItems = [URLQueryItem(name: "l", value: searchText)]
      soccerLeagueViewModel.urlComponents.queryItems = [URLQueryItem(name: "l", value: searchText)]
      print("ContentView: \(URLFromAPI.teams.rawValue)\(searchText)")
      Task {
        soccerLeagueViewModel.teams = try! await soccerLeagueViewModel.load(from: soccerLeagueViewModel.urlComponents, type: LeagueTeams.self).teams
        soccerLeagueViewModel.teams = soccerLeagueViewModel.teams.sorted { $1.strTeam ?? "" < $0.strTeam ?? "" }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
