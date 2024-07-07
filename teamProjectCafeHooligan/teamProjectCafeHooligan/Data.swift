
import UIKit

struct MenuItem {
    let imageName: String
    let menuName: String
    let menuPrice: Double
    var quantity: Int
}


extension MenuItem{
    
    static let best_Menu = [
        MenuItem(imageName: "americano", menuName: "Americano", menuPrice: 1.5, quantity: 1),
        MenuItem(imageName: "cola", menuName: "Coke", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "croque madame", menuName: "Croque madame", menuPrice: 1.8, quantity: 1),
        MenuItem(imageName: "burratta pizza", menuName: "Burratta pizza", menuPrice: 2.4, quantity: 1),
    ]
    
    static let coffee_Menu = [
        MenuItem(imageName: "americano", menuName: "Americano", menuPrice: 1.5, quantity: 1),
        MenuItem(imageName: "cappucino", menuName: "Cappuccino", menuPrice: 1.7, quantity: 1),
        MenuItem(imageName: "espresso", menuName: "Espresso", menuPrice: 0.7, quantity: 1),
        MenuItem(imageName: "latte", menuName: "Latte", menuPrice: 1.6, quantity: 1),
    ]
    
    static let drinks_Menu = [
        MenuItem(imageName: "cola", menuName: "Coke", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "mtn dew", menuName: "Mountain Dew", menuPrice: 1.1, quantity: 1),
        MenuItem(imageName: "red bull", menuName: "Red Bull", menuPrice: 0.9, quantity: 1),
        MenuItem(imageName: "soda", menuName: "Soda", menuPrice: 0.6, quantity: 1),
    ]
    
    static let bites_Menu = [
        MenuItem(imageName: "croque madame", menuName: "Croque madame", menuPrice: 1.8, quantity: 1),
        MenuItem(imageName: "nutella bread", menuName: "Nutella bread", menuPrice: 1.6, quantity: 1),
        MenuItem(imageName: "pancake", menuName: "Pancake", menuPrice: 1.5, quantity: 1),
        MenuItem(imageName: "sandwich", menuName: "Sandwich", menuPrice: 1.0, quantity: 1),
    ]
    
    static let pizza_Menu = [
        MenuItem(imageName: "burratta pizza", menuName: "Burratta pizza", menuPrice: 2.4, quantity: 1),
        MenuItem(imageName: "fineapple pizza", menuName: "Fineapple pizza", menuPrice: 1.9, quantity: 1),
        MenuItem(imageName: "margarita", menuName: "Margarita", menuPrice: 2.2, quantity: 1),
        MenuItem(imageName: "pepperoni", menuName: "Pepperoni", menuPrice: 2.0, quantity: 1),
    ]
}
//카테고리
struct Category {
    let name: String
    let categoryImageName: String
}

extension Category{
    
    static let category = [
        Category(name: "Best", categoryImageName: "logoImage"),
        Category(name: "Coffee", categoryImageName: "category_coffee"),
        Category(name: "Drinks", categoryImageName: "category_drink"),
        Category(name: "Bites", categoryImageName: "category_cookie"),
        Category(name: "Pizza", categoryImageName: "category_pizza")
    ]
}

