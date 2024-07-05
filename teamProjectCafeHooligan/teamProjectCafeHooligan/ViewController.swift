//
//  ViewController.swift
//  teamProjectCafeHooligan
//
//  Created by 단예진 on 7/3/24.
//

import UIKit

// B. 커스텀폰트 추가
enum FontName: String {
    case beirutiMedium = "Beiruti-Medium"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
    
    /// B. beirutiMedium 24
    @nonobjc class var h1: UIFont {
        return UIFont.font(.beirutiMedium, ofSize: 24)
    }
}

// B. ColorSet에 지정한 UIColor : 시스템모드 변경 시 자유로운 색 변경
extension UIColor {
    /// B. Topbar
    class var accentColorCustom: UIColor? { return UIColor(named: "AccentColor") }
    /// B. Toggle Background Color
    class var toggleButtonBackgroundCustom: UIColor? { return UIColor(named: "toggleButtonBackground") }
    /// B. Toggle Symbol Color
    class var toggleButtonSymbolCustom: UIColor? { return UIColor(named: "toggleButtonSymbol") }
}

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
    let modeToggleButton = UIButton(type: .system) // type이 필요한지 실험해볼 것
    
    // B. 시스템모드에 따라 배경을 변경하기 위한 Container View 추가
    let containerView = UIView()
    
    // B. 시스템모드에 따라 변경할 로고 이미지
    let logoImageView = UIImageView(image: UIImage(named: "Logo_dark"))
        
    // B. 시스템모드에 따른 토글 아이콘 사이즈 변경을 위한 UIImage 추가
    let sunImage = UIImage(systemName: "sun.max.fill")
    let moonImage = UIImage(systemName: "moon.fill")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
                
        // B. 로고 이미지
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 8
        
        // B. 로고명 레이블
        let logoLabel = UILabel()
        logoLabel.text = "Café Hooligan"
        logoLabel.font = .h1
        logoLabel.textColor = .label
        
        // B. 다크 모드/라이트 모드 전환 버튼
        modeToggleButton.addTarget(self, action: #selector(toggleMode), for: .touchUpInside)
        
        // B. 시스템모드에 따른 버튼 및 버튼 내 아이콘 색상값
        modeToggleButton.backgroundColor = UIColor.toggleButtonBackground
        modeToggleButton.tintColor = UIColor.toggleButtonSymbol
        
        
        // B. 시스템모드에 따른 Container View 배경색상 전환
        containerView.backgroundColor = UIColor.accentColorCustom
        
        // B. 아이콘 설정
        modeToggleButton.layer.cornerRadius = 8
        
        // B. 토글 버튼 초기 이미지 설정
        updateToggleButtonIcon()
        
        // B. horizontalStackView 생성
        let horizontalStackView = UIStackView(arrangedSubviews: [logoImageView, logoLabel, modeToggleButton])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        
        // B. horizontalStackView를 뷰에 추가
        view.addSubview(horizontalStackView)
        
        // B. containerView에 horizontalView 추가
        containerView.addSubview(horizontalStackView)
        
        // B. ContainerView를 뷰에 추가
        view.addSubview(containerView)
        
        // B. Auto Layout 설정
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // B. Container View 제약 설정
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            // B. Horizontal Stack View 제약 설정
            horizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17),
            horizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -21),
            horizontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            horizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            
            // B. Logo Image 제약 설정
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            modeToggleButton.widthAnchor.constraint(equalToConstant: 40),
            modeToggleButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Create a scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = #colorLiteral(red: 0.9118670225, green: 0.9118669629, blue: 0.9118669629, alpha: 1)
        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
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
    
    // MARK: - method
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
// MARK: - 클래스 밖
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
    
        
    
    // B. 시스템모드(다크모드/라이트모드)를 전환하는 토글
    @objc func toggleMode() {
        // B. 다크 모드/라이트 모드 전환 코드
        if traitCollection.userInterfaceStyle == .light {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        updateToggleButtonIcon() // 모드 전환 후 아이콘 업데이트
    }
    
    // B. 사용자 인터페이스 색상 모드 변화 감지, 이전 색상 모드와 현재 색상 모드가 다를 경우에만 실행
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // B. 현재 인터페이스 스타일에 따라 버튼 이미지 업데이트
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateToggleButtonIcon()
        }
    }
    
    // B. 시스템 모드에 따라 토글 버튼 아이콘 및 로고 업데이트
    private func updateToggleButtonIcon() {
        let isLightMode = traitCollection.userInterfaceStyle == .light
        
        let iconSize = CGSize(width: 12, height: 12) // 원하는 아이콘 크기 설정
        let configuration = UIImage.SymbolConfiguration(pointSize: iconSize.width)
        
        let sunIcon = sunImage?.withConfiguration(configuration)
        let moonIcon = moonImage?.withConfiguration(configuration)
        
        modeToggleButton.setImage(isLightMode ? moonIcon : sunIcon, for: .normal)
        
        // B. 로고 이미지 업데이트
        let logoImageName = isLightMode ? "Logo_light" : "Logo_dark"
        logoImageView.image = UIImage(named: logoImageName)
    }
}
