//
//  ContentView.swift
//  pokedex
//
//  Created by Ivo Junior Bettini on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    
    init() {
        UITableView.appearance().backgroundColor = .red
        }
    
    var body: some View {

        NavigationView {
            
            List {
                ForEach(searchText == "" ? pokemon: pokemon.filter( {$0.name.contains(searchText.lowercased())} )) {
                    entry in
                    
                    HStack {
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        
                        NavigationLink("\(entry.name)".capitalized ,destination:
                                        VStack{
                            PokemonImage(imageLink: "\(entry.url)")
                            Text("\(entry.name)")
                        }
                                       
                        )
                        
                    }
                }.listRowBackground(Color.cyan)
                    
            }
            
            .onAppear {
                PokeApi().getData() { pokemon in
                    self.pokemon = pokemon
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
