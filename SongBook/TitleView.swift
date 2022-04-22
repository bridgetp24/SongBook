//
//  TitleView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/22/22.
//
import SwiftUI

struct TitleBar: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Title: ")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                Text("Description: ")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .padding(.leading)
    }
}
