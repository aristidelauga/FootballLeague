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
    ScrollView(.vertical, showsIndicators: false ){
      VStack(alignment: .leading, spacing: 10) {
        if let banner = soccerLeagueViewModel.selectedTeam.strTeamBanner {
          AsyncImage(url: URL(string: banner)) { image in
            image.resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: UIScreen.main.bounds.width)
              .frame(maxHeight: .infinity)
          } placeholder: {
            ProgressView()
          }
        }
        Text(soccerLeagueViewModel.selectedTeam.strCountry ?? "France")
        Text(soccerLeagueViewModel.selectedTeam.strLeague ?? "French Ligue 1")
          .bold()
        HStack {
          Spacer()
          Text(soccerLeagueViewModel.selectedTeam.description)
          Spacer()
        }
      }
    }
    .navigationTitle(soccerLeagueViewModel.selectedTeam.strTeam ?? "")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(soccerLeagueViewModel: SoccerLeagueViewModel())
  }
}
