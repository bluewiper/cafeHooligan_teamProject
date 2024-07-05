//
//  ViewController.swift
//  teamProjectCafeHooligan
//
//  Created by 단예진 on 7/3/24.
//

import UIKit



//예시 데이터 모델
struct MenuItem {
    var menuName1: String
    var price1: Double
    var quantity: Int
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
    
    //메뉴 아이템 입력
    var menuItems: [MenuItem] = [
        MenuItem(menuName1: "AMERICANO", price1: 3.5, quantity: 1),
        MenuItem(menuName1: "AMERICANO", price1: 3.5, quantity: 1),
        MenuItem(menuName1: "AMERICANO", price1: 3.5, quantity: 1),
        MenuItem(menuName1: "AMERICANO", price1: 3.5, quantity: 1),
        MenuItem(menuName1: "AMERICANO", price1: 3.5, quantity: 1)
    ]
    
    override func viewDidLoad() {
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
            
            buttonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 244)
            
        ])
    }
    //총 수량, 총 가격 로직
    func updateTotalItemsAndPrice() {
        let totalItems = menuItems.reduce(0) { $0 + $1.quantity }
        let totalPrice = menuItems.reduce(0.0) { $0 + ($1.price1 * Double($1.quantity)) }
        
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
            
            cell.nameLabel.text = menuItem.menuName1
            cell.priceLabel.text = "\(menuItem.price1)"
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
}

