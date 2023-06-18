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
    VStack {
      AsyncImage(url: URL(string: soccerLeagueViewModel.selectedTeam.strTeamBanner ??  "https://www.thesportsdb.com/images//media/team/banner/wvaw7l1641382901.jpg")) { image in
//      AsyncImage(url: URL(string: "https://www.thesportsdb.com/images//media/team/banner/wvaw7l1641382901.jpg")!) { image in
        image.resizable()
          .frame(width: UIScreen.main.bounds.width, height: 250)
      } placeholder: {
        ProgressView()
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
