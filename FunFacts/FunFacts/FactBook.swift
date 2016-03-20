//
//  FactBook.swift
//  FunFacts
//
//  Created by Ankit on 16/03/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import Foundation

struct FactBook {
    let factsArray = [
        "It takes the Solar System about 240 million years to complete one orbit of the Galaxy.",
        "The Sun accounts for about 99.86% of the total mass of the Solar System.",
        "Earth is the only place in the Solar System where water can be present in its three states: solid, liquid and vapour.",
        "Earth is the only place in the solar system where a total solar eclipse can happen.",
        "If an atom were as big as the Solar System, a neutrino would as small as a golf ball.",
        "Of all the solar system's planets, Venus is the closest to a twin of Earth, with a similar size, orbit and composition.",
        "Uranus has the coldest planetary atmosphere in the Solar System, with a minimum temperature of -371.56 °F (−224 °C)."
    ]
    
    func randomFact() -> String {
        let unsignedArrayCount = UInt32(factsArray.count)
        let randonNumber = Int(arc4random_uniform(unsignedArrayCount))

        return factsArray[randonNumber]
    }
}
