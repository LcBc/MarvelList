//
//  ListView.swift
//  MarvelList
//
//  Created by Luis Barrios on 25/1/22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject  var viewModel = ListViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 140))
    ]
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack{
                    VStack{
                        ScrollView {
                            LazyVGrid(columns:columns, spacing: 20) {
                                //                              Text("hola")
                                
                                ForEach( viewModel.characters, id: \.id) { heroe in
                                    ListCell(character: heroe)
                                }
                                
                                if !viewModel.listIsFull{
                                    ProgressView()
                                        .onAppear {
                                            viewModel.fetchCharacters()
                                        }
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    VStack {
                        Text("Loading...")
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }.frame(width: geometry.size.width / 2,
                            height: geometry.size.height / 5)
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .opacity(viewModel.isLoading ? 1 : 0)
                }
            }.navigationBarTitle("List of Heroes!")
        }.onAppear(perform: {viewModel.fetchCharacters()})
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
