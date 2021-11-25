//
//  Drink.swift
//  YouDrunk
//
//  Created by Simone Giordano on 15/11/21.
//

import Foundation
enum DrinkType: Int16 {
    case Beer
    case Cocktail
    case WhiteWine
    case RedWine
    case LongDrink
}

enum AlcoholUnit: Int {
    case gl
    case bau
}

let alcoholUnitDictionary = [AlcoholUnit.bau: "bau",
                             AlcoholUnit.gl: "gl"]

let CocktailList = [Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 22.8, drink_name: "Daiquiri"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 10.4, drink_name: "Whiskey Sour"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 28, drink_name: "Negroni"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 19.7, drink_name: "Old Fashioned"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 18, drink_name: "Dry Martini"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 20, drink_name: "Margarita"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 16, drink_name: "Mojito"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 8, drink_name: "Aperol Spritz"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 11.6, drink_name: "Campari Spritz"), Drink(drink_type: DrinkType.Cocktail, alcohol_percentage: 16, drink_name: "Americano")]

let BeerList = [Drink(drink_type: DrinkType.Beer, alcohol_percentage: 3.5, drink_name: "Peroni"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 9, drink_name: "Tennents"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 5, drink_name: "Heineken"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 4.6, drink_name: "Moretti"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 4.7, drink_name: "Ichnusa"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 4.5, drink_name: "Corona"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 5, drink_name: "Becks"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 5.5, drink_name: "Paulaner"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 6.3, drink_name: "Bulldog"), Drink(drink_type: DrinkType.Beer, alcohol_percentage: 6.6, drink_name: "Leffe")]

let WhiteWineList = [Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 10.5, drink_name: "Biancolella"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 12, drink_name: "Pecorino"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 12.5, drink_name: "Greco di Tufo"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 13.5, drink_name: "Gewurztraminer"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 13, drink_name: "Coda di Volpe"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 14, drink_name: "Fiano"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 10, drink_name: "Falanghina"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 10, drink_name: "Chardonnay"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 13.5, drink_name: "Malvasia"), Drink(drink_type: DrinkType.WhiteWine, alcohol_percentage: 13.5, drink_name: "Pinot Grigio")]

let RedWineList = [Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 14, drink_name: "Aglianico"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 18, drink_name: "Primitivo"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 12, drink_name: "Lambrusco"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 14, drink_name: "Chianti"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 15, drink_name: "Montepulciano"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 15, drink_name: "Nero d'Avola"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 13, drink_name: "Pinot Nero"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 13.5, drink_name: "Cabernet Sauvignon"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 16, drink_name: "Malvasia"), Drink(drink_type: DrinkType.RedWine, alcohol_percentage: 12, drink_name: "Merlot")]

let LongDrinkList = [Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 10.9, drink_name: "Bloody Mary"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 12, drink_name: "Tequila Sunrise"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 10.4, drink_name: "Gin Fizz"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 16, drink_name: "Sex on the Beach"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 12, drink_name: "Moscow Mule"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 17, drink_name: "London Mule"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 17, drink_name: "Gin Tonic"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 36, drink_name: "Vodka Lemon"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 13, drink_name: "Gin Lemon"), Drink(drink_type: DrinkType.LongDrink, alcohol_percentage: 5, drink_name: "Mimosa")]


let DrinkListTemp = [CocktailList, BeerList, WhiteWineList, RedWineList, LongDrinkList]
let DrinkList = Array(DrinkListTemp.joined())
class Drink: Hashable {
    
    
    static let drinkDictionary = [DrinkType.Beer: "Beer",
                                  DrinkType.Cocktail: "Cocktail",
                                  DrinkType.WhiteWine: "White Wine",
                                  DrinkType.RedWine: "Red Wine",
                                  DrinkType.LongDrink: "Long Drink"]
    static let drinkMethabolismRatePerMinute = 0.0025
    
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

class DrinkEntry{
    var drink: Drink
    var date: Date
    var mlQuantity: Int
    init(drink: Drink, date: Date, mlQuantity: Int) {
        self.drink = drink
        self.date = date
        self.mlQuantity = mlQuantity
    }
    
}

class DrinkEntryCollection: ObservableObject {
    var drinkentries: [DrinkEntry]
    init() {
        drinkentries = [DrinkEntry]()
    }
}
