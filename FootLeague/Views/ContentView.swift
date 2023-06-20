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
            NavigationLink(destination: DetailView(soccerLeagueViewModel: soccerLeagueViewModel),
                           tag: team.strTeam ?? "",
                           selection: $currentSelection) {
              VStack {
                AsyncImage(url: URL(string: team.strTeamBadge ?? "https://www.thesportsdb.com/images/media/team/fanart/oybkzq1607720313.jpg")!) { image in
                  image.resizable()
                    .frame(maxWidth: 180, maxHeight: 240)
                    .aspectRatio(contentMode: .fill)
                } placeholder: { ProgressView() }
                  .frame(maxWidth: 180, maxHeight: 360)
                Text(team.strTeam ?? "")
              }
              .tag(team.strTeam)
            }
          }
          .onChange(of: currentSelection) { newValue in
            if let selection = currentSelection {
              soccerLeagueViewModel.query(from: &soccerLeagueViewModel.urlComponents,
                                          to: URLComponents.selectedTeam,
                                          name: "t",
                                          value: currentSelection ?? selection)
            }
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
      if !isSearching {
        ForEach(soccerLeagueViewModel.allLeagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText)}) { suggestion in
          Text(suggestion.strLeague)
            .searchCompletion(suggestion.strLeague)
        }
      }
    })
    .onSubmit(of: .search) {
      soccerLeagueViewModel.query(
        from: &soccerLeagueViewModel.urlComponents,
                                  to: URLComponents.teams,
                                  name: "l",
                                  value: searchText
      )
      Task {
        soccerLeagueViewModel.teams = try! await soccerLeagueViewModel.load(from: soccerLeagueViewModel.urlComponents, type: LeagueTeams.self).teams
        soccerLeagueViewModel.teams = soccerLeagueViewModel.filteredTeams(soccerLeagueViewModel.teams.sorted { $1.strTeam ?? "" < $0.strTeam ?? "" })
      }
//      UIApplication.shared.keyWindow?.endEditing(true)
      UIApplication.shared.dismissKeyboard()
      searchText = ""
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
