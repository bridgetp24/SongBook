//
//  LyricView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/7/22.
//

import Foundation
import SwiftUI
/** playable bongos*/
struct LyricView: View {
    var body: some View {
        VStack {
            HStack{
                Spacer()
                TextEditor(text: .constant("Placeholder"))
                    .frame(width: 500.0, height: 500.0)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}

struct Previews_LyricView_Previews: PreviewProvider {
    static var previews: some View {
        LyricView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
