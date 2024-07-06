//
//  CustomCollectionViewCell.swift
//  teamProjectCafeHooligan
//
//  Created by mac on 7/5/24.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    // V 셀의 식별자를 정의합니다.
    static let identifier = "MenuItemCell"
    
    // V 이미지 뷰를 생성합니다.
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // V 이름 라벨을 생성합니다.
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .textColor
        label.font = .h2//UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // V 가격 라벨을 생성합니다.
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .textColor
        label.font = .h2//UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // V 초기화 메서드를 정의합니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .color1 //.darkGray
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        // V 레이아웃 제약 조건을 활성화합니다.
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // V 초기화 실패 시 오류를 던지는 메서드를 정의합니다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // V 셀을 구성하는 메서드를 정의합니다.
    func configure(with menuItem: MenuItem) {
        imageView.image = UIImage(systemName: menuItem.imageName)
        nameLabel.text = menuItem.menuName
        priceLabel.text = "\(menuItem.menuPrice)"
    }
}
