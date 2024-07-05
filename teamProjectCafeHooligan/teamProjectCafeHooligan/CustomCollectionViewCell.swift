//
//  CustomCollectionViewCell.swift
//  teamProjectCafeHooligan
//
//  Created by mac on 7/5/24.
// V 메뉴리스트 셀 만들기

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    // V 셀 식별자 정의
    static let identifier = "MenuItemCell"
    
    // V 셀 내의 이미지뷰 생성
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // V 이름 라벨을 생성합니다.
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.h2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // V 가격 라벨을 생성합니다.
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.h2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // V 초기화 메서드를 정의합니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
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
        // V 이미지 에셋 업로드 되면 systemName -> named로 변경
        imageView.image = UIImage(named: menuItem.imageName)
        nameLabel.text = menuItem.menuName
        priceLabel.text = "\(menuItem.menuPrice)"
    }
}
