
import UIKit

struct MenuItem {
    let imageName: String
    let menuName: String
    let menuPrice: Double
    var quantity: Int
}


extension MenuItem{
    
    static let best_Menu = [
        MenuItem(imageName: "americano", menuName: "AMERICANO", menuPrice: 1.5, quantity: 1),
        MenuItem(imageName: "cola", menuName: "COKE", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "croque madame", menuName: "CROQUE MADAME", menuPrice: 1.8, quantity: 1),
        MenuItem(imageName: "burratta pizza", menuName: "BURRATTA PIZZA", menuPrice: 2.4, quantity: 1),
    ]
    
    static let coffee_Menu = [
        MenuItem(imageName: "americano", menuName: "AMERICANO", menuPrice: 1.5, quantity: 1),
        MenuItem(imageName: "cappucino", menuName: "CAPPUCCINO", menuPrice: 1.7, quantity: 1),
        MenuItem(imageName: "espresso", menuName: "ESPRESSO", menuPrice: 0.7, quantity: 1),
        MenuItem(imageName: "latte", menuName: "LATTE", menuPrice: 1.6, quantity: 1),
    ]
    
    static let drinks_Menu = [
        MenuItem(imageName: "cola", menuName: "COKE", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "mtn dew", menuName: "MOUNTAIN DEW", menuPrice: 1.1, quantity: 1),
        MenuItem(imageName: "red bull", menuName: "RED BULL", menuPrice: 0.9, quantity: 1),
        MenuItem(imageName: "soda", menuName: "SODA", menuPrice: 0.6, quantity: 1),
    ]
    
    static let bites_Menu = [
        MenuItem(imageName: "croque madame", menuName: "CROQUE MADAME", menuPrice: 1.8, quantity: 1),
        MenuItem(imageName: "nutella bread", menuName: "NUTELLA BREAD", menuPrice: 1.6, quantity: 1),
        MenuItem(imageName: "pancake", menuName: "PANCAKE", menuPrice: 1.5, quantity: 1),
        MenuItem(imageName: "sandwich", menuName: "SANDWICH", menuPrice: 1.0, quantity: 1),
    ]
    
    static let pizza_Menu = [
        MenuItem(imageName: "burratta pizza", menuName: "BURRATTA PIZZA", menuPrice: 2.4, quantity: 1),
        MenuItem(imageName: "fineapple pizza", menuName: "FINEAPPLE PIZZA", menuPrice: 1.9, quantity: 1),
        MenuItem(imageName: "margarita", menuName: "MARGARITA", menuPrice: 2.2, quantity: 1),
        MenuItem(imageName: "pepperoni", menuName: "PEPPERONI", menuPrice: 2.0, quantity: 1),
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

