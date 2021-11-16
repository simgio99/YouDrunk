//
//  Drink.swift
//  YouDrunk
//
//  Created by Simone Giordano on 15/11/21.
//

import Foundation
enum DrinkType {
    case Beer
    case Cocktail
    case WhiteWine
    case RedWine
    case LongDrink
}


let CocktailList = [Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 27.1, drink_name: "Generic Cocktail"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 32.3, drink_name: "Whiskey Sour"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 24.3, drink_name: "Negroni")]

let BeerList = [Drink(drink_type: DrinkType.Beer, alcohol_percentage: 7.1, drink_name: "Peroni")]
let WhiteWineList = [Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 9.1, drink_name: "Biancolella")]
let RedWineList = [Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 12.1, drink_name: "Negramaro")]
let LongDrinkList = [Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 22.1, drink_name: "Long Island Ice Tea")]


let DrinkListTemp = [CocktailList, BeerList, WhiteWineList, RedWineList, LongDrinkList]
let DrinkList = Array(DrinkListTemp.joined())
class Drink: Hashable {
    
    
    static let drinkDictionary = [DrinkType.Beer: "Beer",
                                  DrinkType.Cocktail: "Cocktail",
                                  DrinkType.WhiteWine: "White Wine",
                                  DrinkType.RedWine: "Red Wine",
                                  DrinkType.LongDrink: "Long Drink"]
    
    
    var type: DrinkType
    var alcoholPercentage: Float
    var drinkName: String
    init(drink_type: DrinkType, alcohol_percentage: Float, drink_name: String) {
        self.type = drink_type
        self.alcoholPercentage = alcohol_percentage
        self.drinkName = drink_name
    }
    static func ==(lhs: Drink, rhs: Drink) -> Bool {
        return lhs.drinkName == rhs.drinkName
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(drinkName)
    }
}

struct DrinkEntry {
    var drink: Drink
    var date: Date
    
}
