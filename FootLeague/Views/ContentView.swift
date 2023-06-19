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
            NavigationLink(
              destination: DetailView(soccerLeagueViewModel: soccerLeagueViewModel),
              tag: team.idTeam ?? "",
              selection: $currentSelection) {
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
                .tag(team.idTeam)
                .onChange(of: currentSelection) { newValue in
                  let newValue = newValue
                  if let selectedTeam = soccerLeagueViewModel.teams.first(where: { $0.idTeam == newValue }) {
                    currentTeam = selectedTeam.strTeam
                  }
                }
              }
          }
          .onChange(of: currentTeam) { newValue in
            soccerLeagueViewModel.urlComponents = URLComponents.selectedTeam
            soccerLeagueViewModel.urlComponents.queryItems = [URLQueryItem(name: "t", value: newValue)]
            Task {
              soccerLeagueViewModel.selectedTeam = try! await soccerLeagueViewModel.load(from: soccerLeagueViewModel.urlComponents, type: LeagueTeams.self).teams.first!
            }
          }
        }
      }
    }
    .onAppear {
      Task {
        soccerLeagueViewModel.allLeagues = try! await soccerLeagueViewModel.load(from: URLComponents.league, type: SoccerLeague.self).leagues
      }
    }
    .searchable(text: $searchText, prompt: "Search by league", suggestions: {
      if !isSearching && !searchText.isEmpty {
        ForEach(soccerLeagueViewModel.allLeagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText)}) { suggestion in
          Text(suggestion.strLeague)
            .searchCompletion(suggestion.strLeague)
        }
      }
      if !isSearching {
        ForEach(soccerLeagueViewModel.allLeagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText)}) { suggestion in
          Text(suggestion.strLeague)
            .searchCompletion(suggestion.strLeague)
        }
      }
    })
    .onSubmit(of: .search) {
      soccerLeagueViewModel.urlComponents = URLComponents.teams
      soccerLeagueViewModel.urlComponents.queryItems = [URLQueryItem(name: "l", value: searchText)]
      Task {
        soccerLeagueViewModel.teams = try! await soccerLeagueViewModel.load(from: soccerLeagueViewModel.urlComponents, type: LeagueTeams.self).teams
        soccerLeagueViewModel.teams = soccerLeagueViewModel.teams.sorted { $1.strTeam ?? "" < $0.strTeam ?? "" }
        
        
        //MARK: Team filtering
        var filteredTeams: [Team] = []
        for index in 0..<soccerLeagueViewModel.teams.count {
          if (index % 2) == 0 {
            filteredTeams.append(soccerLeagueViewModel.teams[index])
          }
        }
        soccerLeagueViewModel.teams = filteredTeams
      }
      UIApplication.shared.keyWindow?.endEditing(true)
      searchText = ""
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
 
 //    .searchable(text: $searchText, prompt: "Search by league", suggestions: {
 //      if searchText.isEmpty {
 //        ForEach(soccerLeagueViewModel.allLeagues, id: \.idLeague) { suggestion in
 //          Text(suggestion.strLeague)
 //            .searchCompletion(suggestion.strLeague)
 //        }
 //      }
 //    })
 
 */
