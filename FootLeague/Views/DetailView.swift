//
//  DetailView.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 18/06/2023.
//

import SwiftUI

struct DetailView: View {
  @ObservedObject var soccerLeagueViewModel: SoccerLeagueViewModel
  var body: some View {
    ScrollView(.vertical, showsIndicators: false ) {
      VStack(alignment: .leading, spacing: 10) {
        if let banner = soccerLeagueViewModel.selectedTeam.strTeamBanner,
           let countryName = soccerLeagueViewModel.selectedTeam.strCountry,
           let league = soccerLeagueViewModel.selectedTeam.strLeague,
           let teamName = soccerLeagueViewModel.selectedTeam.strTeam {
          AsyncImage(url: URL(string: banner)) { image in
            image.resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: UIScreen.main.bounds.width)
              .frame(maxHeight: .infinity)
          } placeholder: { ProgressView() }
          Text(countryName)
          Text(league)
            .bold()
          HStack {
            Spacer()
            Text(soccerLeagueViewModel.selectedTeam.description)
            Spacer()
          }
          .navigationTitle(teamName)
          .navigationBarTitleDisplayMode(.inline)
        }
      }
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(soccerLeagueViewModel: SoccerLeagueViewModel())
  }
}
