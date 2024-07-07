
import UIKit

struct MenuItem {
    let imageName: String
    let menuName: String
    let menuPrice: Double
    var quantity: Int
}


extension MenuItem{
    
//    static let recommended_Menu = [
//        MenuItem(imageName: "americano", menuName: "Americano", menuPrice: 1.3, quantity: 1),
//        MenuItem(imageName: "cappucino", menuName: "Cappuccino", menuPrice: 1.0, quantity: 1),
//        MenuItem(imageName: "espresso", menuName: "Espresso", menuPrice: 0.8, quantity: 1),
//        MenuItem(imageName: "latte", menuName: "Latte", menuPrice: 1.4, quantity: 1),
//    ]
//    
    static let best_Menu = [
        MenuItem(imageName: "americano", menuName: "Americano", menuPrice: 1.3, quantity: 1),
        MenuItem(imageName: "cola", menuName: "Coke", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "croque madame", menuName: "Croque madame", menuPrice: 0.8, quantity: 1),
        MenuItem(imageName: "burratta pizza", menuName: "Burratta pizza", menuPrice: 1.4, quantity: 1),
    ]
    
    static let coffee_Menu = [
        MenuItem(imageName: "americano", menuName: "Americano", menuPrice: 1.3, quantity: 1),
        MenuItem(imageName: "cappucino", menuName: "Cappuccino", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "espresso", menuName: "Espresso", menuPrice: 0.8, quantity: 1),
        MenuItem(imageName: "latte", menuName: "Latte", menuPrice: 1.4, quantity: 1),
    ]
    
    static let drinks_Menu = [
        MenuItem(imageName: "cola", menuName: "Coke", menuPrice: 1.3, quantity: 1),
        MenuItem(imageName: "mtn dew", menuName: "Mountain Dew", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "red bull", menuName: "Red Bull", menuPrice: 0.8, quantity: 1),
        MenuItem(imageName: "soda", menuName: "Soda", menuPrice: 1.4, quantity: 1),
    ]
    
    static let bites_Menu = [
        MenuItem(imageName: "croque madame", menuName: "Croque madame", menuPrice: 1.3, quantity: 1),
        MenuItem(imageName: "nutella bread", menuName: "Nutella bread", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "pancake", menuName: "Pancake", menuPrice: 0.8, quantity: 1),
        MenuItem(imageName: "sandwich", menuName: "Sandwich", menuPrice: 1.4, quantity: 1),
    ]
    
    static let pizza_Menu = [
        MenuItem(imageName: "burratta pizza", menuName: "Burratta pizza", menuPrice: 1.3, quantity: 1),
        MenuItem(imageName: "fineapple pizza", menuName: "Fineapple pizza", menuPrice: 1.0, quantity: 1),
        MenuItem(imageName: "margarita", menuName: "Margarita", menuPrice: 0.8, quantity: 1),
        MenuItem(imageName: "pepperoni", menuName: "Pepperoni", menuPrice: 1.4, quantity: 1),
    ]
}
//라이트모드 카테고리
struct Category_LightMode {
    let name: String
    let categoryImageName: String
}

extension Category_LightMode{
    
    static let category_LightMode = [
        Category_LightMode(name: "Best", categoryImageName: "logoImage"),
        Category_LightMode(name: "Coffee", categoryImageName: "category_coffee"),
        Category_LightMode(name: "Drinks", categoryImageName: "category_drink"),
        Category_LightMode(name: "Bites", categoryImageName: "category_cookie"),
        Category_LightMode(name: "Pizza", categoryImageName: "category_pizza")
    ]
}
//다크모드 카테고리
struct Category_DarkMode {
    let name: String
    let categoryImageName: String
}

extension Category_DarkMode {
    
    static let category_DarkMode = [
        Category_LightMode(name: "Best", categoryImageName: "logoImage"),
        Category_LightMode(name: "Coffee", categoryImageName: "category_coffee"),
        Category_LightMode(name: "Drinks", categoryImageName: "category_drink"),
        Category_LightMode(name: "Bites", categoryImageName: "category_cookie"),
        Category_LightMode(name: "Pizza", categoryImageName: "category_pizza")
    ]
}
