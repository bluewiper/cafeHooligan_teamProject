//
//  ViewController.swift
//  teamProjectCafeHooligan
//
//  Created by 단예진 on 7/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    let categories = ["coffeeCup", "drink", "bites", "pizza", "cookie"]
    let categoryTitles = ["Coffee Cup", "Drink", "Bites", "Pizza", "Cookie"]
    let categoriesImage = ["cup.and.saucer", "wineglass", "carrot", "fork.knife", "birthday.cake"]
    
    // 컬렉션뷰 생성
    let menuCollectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // 속성
        collectionView.backgroundColor = #colorLiteral(red: 0.9118670225, green: 0.9118669629, blue: 0.9118669629, alpha: 1)
        
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Create a scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = #colorLiteral(red: 0.9118670225, green: 0.9118669629, blue: 0.9118669629, alpha: 1)
        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            scrollView.heightAnchor.constraint(equalToConstant: 55)
        ])

        // Create a stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 32)
        ])

        // Add buttons to the stack view
        for i in 0..<categoriesImage.count {
            let button = createCategoryButton(imageName: categoriesImage[i], title: categoryTitles[i])
            stackView.addArrangedSubview(button)
        }
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        view.addSubview(menuCollectionView)
        
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            menuCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: menuCollectionView.topAnchor, constant: 473)
        ])
        
        
        menuCollectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuCell")
        
    }
    func createCategoryButton(imageName: String, title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Image
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Title
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack view for image and label
        let innerStackView = UIStackView(arrangedSubviews: [imageView, label])
        innerStackView.axis = .horizontal
        innerStackView.alignment = .center
        innerStackView.spacing = 8
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(innerStackView)
        
        NSLayoutConstraint.activate([
            innerStackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            innerStackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 8),
            innerStackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -8),
            button.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        return button
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuItemCell
        cell.configure(with: MenuItem.recommended_Menu[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 212)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
}
