//
//  DetailView.swift
//  MarvelList
//
//  Created by Luis Barrios on 25/1/22.
//

import SwiftUI

struct DetailView: View {
    @State var  character:MarvelCharacter
    var body: some View {
        ScrollView{
            LazyVStack{
                VStack{
                    if let url = character.thumbnail.fullPath {
                        AsyncImage(
                            url: url,
                            placeholder: { Text("Loading ...") }
                        ).aspectRatio(contentMode: .fit).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                            )
                            .padding([.top, .horizontal])
                        
                    }else{
                        Image(uiImage: #imageLiteral(resourceName: "not-found"))
                            .resizable().aspectRatio(contentMode: .fit)
                    }
                    HStack{
                        VStack(alignment: .leading) {
                            Text("\(character.name)")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.primary).fixedSize(horizontal: false, vertical: true)
                            Text("Bio").font(.title3) .fontWeight(.black)
                                .foregroundColor(.primary)
                            Text(character.description == "" ? "N/A" : character.description )
                            //                            Text("Origin: \(artwork.place_of_origin ?? "Unknown")")
                            //                                .font(.title3)
                            //                                .foregroundColor(.secondary)
                            //                                .lineLimit(3)
                            //                            Text("Period: \(artwork.date_display ?? "Unknown")")
                            //                                .font(.headline)
                            //                                .foregroundColor(.secondary)
                            //                                .lineLimit(3)
                            //                            Text("Style: \(artwork.style_title ?? "Unknown")")
                            //                                .font(.headline)
                            //                                .foregroundColor(.secondary)
                            //                                .lineLimit(3)
                            //                            Text("Materials: \(artwork.medium_display ?? "Unknown")")
                            //                                .font(.caption)
                            //                                .foregroundColor(.secondary)
                            //                                .lineLimit(3)
                            //                            Text("Dimensions: \(artwork.dimensions ?? "Unknown")")
                            //                                .font(.caption)
                            //                                .foregroundColor(.secondary)
                            //                                .lineLimit(3)
                        }.onAppear{
                            
                        }
                        Spacer()
                    }.padding()
                    
                    
                }
            }
        }.navigationBarTitle("Hero Detail")
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let char = MarvelCharacter(id: 0, name: "test", description: "description", thumbnail: Thumbnail(path: "path", type: ".json"))
        DetailView(character: char)
    }
}
