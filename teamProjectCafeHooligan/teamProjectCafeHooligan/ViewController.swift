//
//  ViewController.swift
//  teamProjectCafeHooligan
//
//  Created by 단예진 on 7/3/24.
//

import UIKit
//3단합체 완료입니다.



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
    
    @nonobjc class var h2: UIFont {
        return UIFont.font(.beirutiMedium, ofSize: 18)
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


// MARK: - 클래스 밖
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.identifier, for: indexPath) as! MenuItemCell
        cell.configure(with: menuItems[indexPath.item])
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



//테이블 뷰 안에 셀 요소 정의
class OrderTableCell: UITableViewCell {
    //수량 레이블
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    //가격 레이블
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        //        label.backgroundColor = .red
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    //메뉴명 레이블
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        //        label.backgroundColor = .red
        label.textColor = UIColor.black
        return label
    }()
    //플러스 버튼
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.8901961446, green: 0.8901961446, blue: 0.8901961446, alpha: 1)
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        return button
    }()
    //마이너스 버튼
    let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.8901961446, green: 0.8901961446, blue: 0.8901961446, alpha: 1)
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 5
        return stackView
    }()
    
    weak var delegate:OrderTableCellDelegate?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(hStackView)
        
        vStackView.addArrangedSubview(nameLabel)
        vStackView.addArrangedSubview(priceLabel)
        
        hStackView.addArrangedSubview(totalLabel)
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(plusButton)
        hStackView.addArrangedSubview(minusButton)
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
            
            totalLabel.widthAnchor.constraint(equalToConstant: 44),
            totalLabel.heightAnchor.constraint(equalToConstant: 44),
            
            plusButton.widthAnchor.constraint(equalToConstant: 44),
            plusButton.heightAnchor.constraint(equalToConstant: 44),
            
            minusButton.widthAnchor.constraint(equalToConstant: 44),
            minusButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc func plusButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapPlusButton(on: self, at: indexPath)
    }
    
    @objc func minusButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapMinusButton(on: self, at: indexPath)
    }
    
    
}

protocol OrderTableCellDelegate: AnyObject {
    func didTapPlusButton(on cell: OrderTableCell, at indexPath: IndexPath)
    func didTapMinusButton(on cell: OrderTableCell, at indexPath: IndexPath)
}

// 버튼 동작 관련
class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3) : originalBackgroundColor
        }
    }
    
    private var originalBackgroundColor: UIColor?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        originalBackgroundColor = backgroundColor
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.bounds.contains(point) {
            return self
        }
        
        for subview in self.subviews {
            let pointInSubview = subview.convert(point, from: self)
            if let hitView = subview.hitTest(pointInSubview, with: event) {
                return hitView
            }
        }
        
        return nil
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OrderTableCellDelegate {
    
//    
//    let categories = ["Best", "Coffee", "Drink", "Bites", "Pizza"]
//    let categoryTitles = ["Best", "Coffee", "Drink", "Bites", "Pizza"]
//    let categoriesImage = ["cup.and.saucer", "wineglass", "carrot", "fork.knife", "birthday.cake"]
    
    let categoriesLightMode = Category_LightMode.category_LightMode
    let categoriesDarkMode = Category_DarkMode.category_DarkMode
    var menuItems = MenuItem.best_Menu
    
    
    
    
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
        for (index, _) in categoriesLightMode.enumerated() {
            let button = createCategoryButton(imageName: categoriesDarkMode[index].categoryImageName, title: categoriesDarkMode[index].name, tag: index)
            stackView.addArrangedSubview(button)
        }
        // 기본적으로 "Best" 버튼에 스트로크 설정
        if let bestButton = stackView.arrangedSubviews.first as? UIButton {
            bestButton.layer.borderWidth = 2
            bestButton.layer.borderColor = UIColor.red.cgColor
        }
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        view.addSubview(menuCollectionView)
        
        menuCollectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.identifier)
        
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            menuCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: menuCollectionView.topAnchor, constant: 473)
        ])
        
        
        menuCollectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuCell")
        //하단
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(buttonContainer)
        view.addSubview(topOverLayView)
        view.addSubview(topLineView)
        
        buttonContainer.addSubview(deleteButton)
        buttonContainer.addSubview(checkoutButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTableCell.self, forCellReuseIdentifier: "OrderTableCell")
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 100, right: 0)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            topLineView.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            topLineView.widthAnchor.constraint(equalToConstant: 366),
            topLineView.heightAnchor.constraint(equalToConstant: 2),
            topLineView.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            
            topOverLayView.topAnchor.constraint(equalTo: tableView.topAnchor),
            topOverLayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topOverLayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topOverLayView.heightAnchor.constraint(equalToConstant: 13),
            
            buttonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            buttonContainer.heightAnchor.constraint(equalToConstant: 96),
            buttonContainer.widthAnchor.constraint(equalToConstant: 393),
            
            deleteButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 15),
            deleteButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            deleteButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 8),
            deleteButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: -36),
            deleteButton.widthAnchor.constraint(equalToConstant: 128),
            
            
            checkoutButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -17),
            checkoutButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            checkoutButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 8),
            checkoutButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: -36),
            checkoutButton.widthAnchor.constraint(equalToConstant: 220),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor, constant: -25),
            tableView.heightAnchor.constraint(equalToConstant: 244)
            
        ])

    }
    
    // MARK: - method
    func createCategoryButton(imageName: String, title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
       
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tag = tag
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        
        // Image
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Title
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        
        // Stack view for image and label
        let innerStackView = UIStackView(arrangedSubviews: [imageView, label])
        innerStackView.axis = .horizontal
        innerStackView.alignment = .center
        innerStackView.spacing = 8
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        innerStackView.isUserInteractionEnabled = false
        
        button.addSubview(innerStackView)
        
        NSLayoutConstraint.activate([
            innerStackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            innerStackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 8),
            innerStackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -8),
            button.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        return button
    }
    
    
    let topOverLayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8901961446, green: 0.8901961446, blue: 0.8901961446, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    let topLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.opacity = 0.5
        return view
    }()
    
    //테이블 뷰
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.8901961446, green: 0.8901961446, blue: 0.8901961446, alpha: 1)
        tv.layer.cornerRadius = 10
        return tv
    }()
    //전체 삭제 버튼
    let deleteButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "0"
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.isUserInteractionEnabled = false
        
        let imageView = UIImageView(image: UIImage(systemName: "cup.and.saucer.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.isUserInteractionEnabled = false
        
        let deleteLabel = UILabel()
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteLabel.font = .systemFont(ofSize: 16)
        deleteLabel.text = "DELETE"
        deleteLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        deleteLabel.isUserInteractionEnabled = false
        
        
        let stackView = UIStackView(arrangedSubviews: [label, imageView, deleteLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }()
    
    
    //결제하기 버튼
    let checkoutButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        button.layer.cornerRadius = 5
        
        
        let imageView = UIImageView(image: UIImage(systemName: "dollarsign.square.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "0.0"
        label.textColor = .white
        label.isUserInteractionEnabled = false
        
        let checkOutLabel = UILabel()
        checkOutLabel.translatesAutoresizingMaskIntoConstraints = false
        checkOutLabel.font = .systemFont(ofSize: 16)
        checkOutLabel.text = "CHECK OUT"
        checkOutLabel.textColor = .white
        checkOutLabel.isUserInteractionEnabled = false
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label, checkOutLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        
        return button
    }()
    
    
    
    
    
    //버튼 컨테이너
    let buttonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        return view
    }()
    // 카테고리 데이터
//    let categoriesLightMode = Category_LightMode.category_LightMode
//    let categoriesDarkMode = Category_DarkMode.category_DarkMode
//
    //메뉴 아이템 입력
//    var menuItems = MenuItem.best_Menu
 
    //총 수량, 총 가격 로직
    func updateTotalItemsAndPrice() {
        let totalItems = menuItems.reduce(0) { $0 + $1.quantity }
        let totalPrice = menuItems.reduce(0.0) { $0 + ($1.menuPrice * Double($1.quantity)) }
        
        if let deleteLabel = (deleteButton.subviews.first as? UIStackView)?.arrangedSubviews[0] as? UILabel {
            deleteLabel.text = "\(totalItems)"
        }
        
        if let priceLabel = (checkoutButton.subviews.first as? UIStackView)?.arrangedSubviews[1] as? UILabel {
            priceLabel.text = String(format: "%.1f", totalPrice)
        }
        
        tableView.isScrollEnabled = !menuItems.isEmpty
    }
    
    //전체 삭제 버튼 로직
    @objc func deleteButtonTapped() {
        menuItems.removeAll()
        tableView.reloadData()
        updateTotalItemsAndPrice()
    }
    
    //결제완료 버튼 로직
    @objc func checkoutButtonTapped() {
        if menuItems.isEmpty {
            showEmptyCartAlert()
        } else {
            self.menuItems.removeAll()
            self.tableView.reloadData()
            self.updateTotalItemsAndPrice()
            self.showEnjoyYourCoffee()
        }
    }
    //빈 장바구니 알림창
    func showEmptyCartAlert() {
        let alert = UIAlertController(title: "Alert", message: "Your cart is empty.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // 버튼 애니메이션
    func showEnjoyYourCoffee() {
        if let stackView = checkoutButton.subviews.first as? UIStackView,
           let imageView = stackView.arrangedSubviews[0] as? UIImageView,
           let label = stackView.arrangedSubviews[1] as? UILabel,
           let checkOutLabel = stackView.arrangedSubviews[2] as? UILabel {
            
            _ = stackView.spacing
            
            UIView.animate(withDuration: 0.3, animations: {
                label.alpha = 0
                checkOutLabel.alpha = 0
                imageView.alpha = 0
            }) { _ in
                
                label.text = ""
                checkOutLabel.text = "ENJOY YOUR COFFEE"
                self.checkoutButton.backgroundColor = .white
                checkOutLabel.textColor = .black
                imageView.image = UIImage(systemName: "cup.and.saucer.fill")
                imageView.tintColor = .black
                stackView.spacing = 5
                
                UIView.animate(withDuration: 0.3) {
                    label.alpha = 1
                    checkOutLabel.alpha = 1
                    imageView.alpha = 1
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                
                UIView.animate(withDuration: 0.3, animations: {
                    label.alpha = 0
                    checkOutLabel.alpha = 0
                    imageView.alpha = 0
                }) { _ in
                    label.text = "0.0"
                    checkOutLabel.text = "CHECK OUT"
                    checkOutLabel.textColor = .white
                    self.checkoutButton.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.2196078431, blue: 0.262745098, alpha: 1)
                    self.checkoutButton.tintColor = .white
                    imageView.image = UIImage(systemName: "dollarsign.square.fill")
                    imageView.tintColor = .white
                    
                    UIView.animate(withDuration: 0.3) {
                        
                        checkOutLabel.alpha = 1
                        imageView.alpha = 1
                        label.alpha = 1
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.isEmpty ? 1 : menuItems.count
    }
    
    // 셀 내부 요소 정보 표시
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if menuItems.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell") ?? UITableViewCell(style: .default, reuseIdentifier: "EmptyStateCell")
            
            for subview in cell.contentView.subviews {
                subview.removeFromSuperview()
            }
            
            let messageLabel = UILabel()
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.textColor = .black
            messageLabel.font = .systemFont(ofSize: 14)
            messageLabel.backgroundColor = .white
            messageLabel.layer.cornerRadius = 12
            messageLabel.clipsToBounds = true
            let fullText = """
                    Heart health
                    
                    Coffee may lower the risk of stroke and heart failure, and improve overall heart health.Research suggests that drinking 3–5 cups of coffee per day may maximize these benefits.
                    """
            let boldText = "Heart health"
            
            let attributedString = NSMutableAttributedString(string: fullText)
            let boldRange = (fullText as NSString).range(of: boldText)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: boldRange)
            
            messageLabel.attributedText = attributedString
            
            cell.contentView.addSubview(messageLabel)
            
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                messageLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
                messageLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                messageLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -20),
                messageLabel.heightAnchor.constraint(equalToConstant: 130)
                
            ])
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableCell", for: indexPath) as! OrderTableCell
            let menuItem = menuItems[indexPath.row]
            
            cell.nameLabel.text = menuItem.menuName
            cell.priceLabel.text = "\(menuItem.menuPrice)"
            cell.totalLabel.text = "\(menuItem.quantity)"
            cell.indexPath = indexPath
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            
            return cell
        }
    }
    //테이블 뷰 셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if menuItems.isEmpty {
            return UITableView.automaticDimension
        } else {
            return 78
        }
    }
    
    // + 버튼 로직
    func didTapPlusButton(on cell: OrderTableCell, at indexPath: IndexPath) {
        menuItems[indexPath.row].quantity += 1
        tableView.reloadRows(at: [indexPath], with: .none)
        updateTotalItemsAndPrice()
    }
    // - 버튼 로직
    func didTapMinusButton(on cell: OrderTableCell, at indexPath: IndexPath) {
        if menuItems[indexPath.row].quantity > 1 {
            menuItems[indexPath.row].quantity -= 1
            tableView.reloadRows(at: [indexPath], with: .none)
            updateTotalItemsAndPrice()
        }
    }
    // 카테고리 버튼 클릭시 태그 전달
    @objc func categoryButtonTapped(_ sender: UIButton) {
           for case let button as UIButton in (sender.superview?.subviews ?? []) {
               button.layer.borderWidth = 0
               button.layer.borderColor = UIColor.clear.cgColor
           }
           
           sender.layer.borderWidth = 2
           sender.layer.borderColor = UIColor.red.cgColor
        
        switch sender.tag {
        case 0:
            menuItems = MenuItem.best_Menu
        case 1:
            menuItems = MenuItem.coffee_Menu
        case 2:
            menuItems = MenuItem.drinks_Menu
        case 3:
            menuItems = MenuItem.bites_Menu
        case 4:
            menuItems = MenuItem.pizza_Menu
        default:
            menuItems = []
        }
        menuCollectionView.reloadData() // 데이터 변경 후 컬렉션뷰 리로드
    }
}
 
