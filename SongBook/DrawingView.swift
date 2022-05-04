//
//  DrawingView.swift
//  Drawing Pencil Kit
//
//  Created by Bridget on 4.22.22

import SwiftUI

struct DrawingView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    var body: some View {
        VStack{
            HStack {
                // canvas
                ZStack {
                    DrawingCanvasView(data: data ?? Data(), id: id ?? UUID())
                        .environment(\.managedObjectContext, viewContext)
                        .navigationBarTitle(title ?? "Untitled",displayMode: .inline)
                        .padding(.all)
                }.background(
                    Image("leatherBackground")
                        .resizable()
                     
                )
                // widgets
                VStack {
                    ScrollView {
                        KeyWidget()
                        RecordWidget(title: title ?? "untitled")
                        DrumPad()
                    }.padding(.all)
                }.background(
                    Image("leatherBackground")
                        .resizable()
                     
                )
            }

        }
    }
}

