//
//  ContentView.swift
//  GuessTheFunko
//
//  Created by Alex Chase on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(FunkoCard.allCards) { card in
                    Image(uiImage: card.uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .onTapGesture {
                            print("TODO: handle SwiftUI tap")
                        }
                }
            }
            .padding(.horizontal)
            
            Text("Score:")
                .font(.title2)
        }
    }
    
    let columns = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
