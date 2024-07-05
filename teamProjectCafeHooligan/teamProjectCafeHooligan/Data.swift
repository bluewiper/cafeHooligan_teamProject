
import UIKit

struct MenuItem {
    let imageName: String
    let menuName: String
    let menuPrice: Double
}


extension MenuItem{
    
    static let recommended_Menu = [
        MenuItem(imageName: "cup.and.saucer", menuName: "coffee", menuPrice: 1.3),
        MenuItem(imageName: "star", menuName: "cappuccino", menuPrice: 1.0),
        MenuItem(imageName: "cup.and.saucer", menuName: "cafemocha", menuPrice: 0.8),
        MenuItem(imageName: "star", menuName: "peachtea", menuPrice: 1.4),
    ]
}
struct Category {
    let name: String
}
