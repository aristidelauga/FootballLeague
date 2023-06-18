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
  @State private var currentSelection: String? = nil
  @State private var currentTeam: String? = nil
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
            NavigationLink(destination: VStack {
              DetailView(soccerLeagueViewModel: soccerLeagueViewModel)
            }, tag: team.idTeam ?? "", selection: $currentSelection) {
              VStack {
                AsyncImage(url: URL(string: team.strTeamBadge ?? "https://www.thesportsdb.com/images/media/team/fanart/oybkzq1607720313.jpg")!) { image in
                  image.resizable()
                    .frame(maxWidth: 180, maxHeight: 240)
                    .aspectRatio(contentMode: .fill)
                } placeholder: {
                  ProgressView()
                }
                .frame(maxWidth: 180, maxHeight: 360)
                Text(team.strTeam ?? "")
              }
            }
            .tag(team.idTeam)
            .onChange(of: currentSelection) { newValue in
              let newValue = newValue
              if let selectedTeam = soccerLeagueViewModel.teams.first(where: { $0.idTeam == newValue }) {
                currentTeam = selectedTeam.strTeam
              }
            }
          }
          .onChange(of: currentTeam) { newValue in
            soccerLeagueViewModel.urlComponents.scheme = "https"
            soccerLeagueViewModel.urlComponents.host = "thesportsdb.com"
            soccerLeagueViewModel.urlComponents.path = "/api/v1/json/50130162/searchteams.php"
            soccerLeagueViewModel.urlComponents.queryItems = [URLQueryItem(name: "t", value: newValue)]
            print(soccerLeagueViewModel.urlComponents.url ?? "")
            Task {
              soccerLeagueViewModel.selectedTeam = try! await soccerLeagueViewModel.load(from: soccerLeagueViewModel.urlComponents, type: LeagueTeams.self).teams.first!
            }
          }
        }
      }
    }
    .onAppear {
      soccerLeagueViewModel.urlComponents.scheme = "https"
      soccerLeagueViewModel.urlComponents.host = "thesportsdb.com"
      soccerLeagueViewModel.urlComponents.path = "/api/v1/json/50130162/all_leagues.php"
      Task {
        soccerLeagueViewModel.allLeagues = try! await soccerLeagueViewModel.load(from: soccerLeagueViewModel.urlComponents, type: SoccerLeague.self).leagues
      }
    }
    .searchable(text: $searchText, prompt: "Search by league", suggestions: {
      if searchText.isEmpty {
        ForEach(soccerLeagueViewModel.allLeagues, id: \.idLeague) { suggestion in
          Text(suggestion.strLeague)
            .searchCompletion(suggestion.strLeague)
        }
      }
    })
    .onSubmit(of: .search) {
      soccerLeagueViewModel.urlComponents.scheme = "https"
      soccerLeagueViewModel.urlComponents.host = "thesportsdb.com"
      soccerLeagueViewModel.urlComponents.path = "/api/v1/json/50130162/search_all_teams.php"
      soccerLeagueViewModel.urlComponents.queryItems = [URLQueryItem(name: "l", value: searchText)]
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


/*
 
 
 NavigationLink {
 VStack {
 Text(soccerLeagueViewModel.selectedTeam.strTeam ?? "No value")
 }
 } label: {
 VStack {
 AsyncImage(url: URL(string: team.strTeamBadge ?? "https://www.thesportsdb.com/images/media/team/fanart/oybkzq1607720313.jpg")!) { image in
 image.resizable()
 .frame(maxWidth: 180, maxHeight: 240)
 .aspectRatio(contentMode: .fill)
 } placeholder: {
 ProgressView()
 }
 .frame(maxWidth: 180, maxHeight: 360)
 Text(team.strTeam ?? "")
 }
 }
 
 
 NavigationLink(destination: VStack {
 
 Text(soccerLeagueViewModel.selectedTeam.strTeam ?? "No value")
 }, tag: team.idTeam ?? "", selection: $currentSelection) {
 
 */


// MARK: working version:

/*
 
 NavigationLink {
 Text(soccerLeagueViewModel.selectedTeam.strTeam ?? "No value")
 } label: {
 VStack {
 AsyncImage(url: URL(string: team.strTeamBadge ?? "https://www.thesportsdb.com/images/media/team/fanart/oybkzq1607720313.jpg")!) { image in
 image.resizable()
 .frame(maxWidth: 180, maxHeight: 240)
 .aspectRatio(contentMode: .fill)
 } placeholder: {
 ProgressView()
 }
 .frame(maxWidth: 180, maxHeight: 360)
 Text(team.strTeam ?? "")
 }
 }
 
 */
