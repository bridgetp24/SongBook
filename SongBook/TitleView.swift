//
//  TitleView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/22/22.
//
import SwiftUI

struct TitleBar: View {
    @State var title = ""
    @State var description = ""
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TextField("Title", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                TextField("Description", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    
            }
            Spacer()
        }
        .padding(.leading)
    }
}
