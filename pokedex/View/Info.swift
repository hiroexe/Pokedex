//
//  PokemonImage.swift
//  pokedex
//
//  Created by Ivo Junior Bettini on 21/06/22.
//

import SwiftUI

struct PokemonSize: View {
    var sizeLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        
        
    }
    
    func getSprite(url: String) {
        var tempSprite: String?
        PokemonSelectedInfo().getInfo(url: url) { size in
            tempSprite = String(size.weight)
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
        
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
            .previewInterfaceOrientation(.portrait)
    }
}
