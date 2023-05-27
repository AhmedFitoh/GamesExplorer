//
//  ButtonView.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//


import UIKit
class ButtonView: UIView {

    private let dividerTopView = UIView()
    private let dividerBottomView = UIView()
    private let titleLabel = UILabel()
    private var hasBottomDivider: Bool = false

    convenience init(title: String, hasBottomDivider: Bool) {
        self.init(frame: .zero)
        self.hasBottomDivider = hasBottomDivider
        setupUI(title: title)
        setupBottomDivider()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 54)
    }
}


extension ButtonView {
    
    func setupUI() {
        addSubview(dividerTopView)
        addSubview(titleLabel)
        addSubview(dividerBottomView)
        
        NSLayoutConstraint.activate([
            dividerTopView.heightAnchor.constraint(equalToConstant: 0.5),
            dividerTopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerTopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerTopView.topAnchor.constraint(equalTo: topAnchor),

            dividerBottomView.heightAnchor.constraint(equalToConstant: 0.5),
            dividerBottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerBottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerBottomView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
        
        dividerTopView.backgroundColor = UIColor.black
        dividerTopView.translatesAutoresizingMaskIntoConstraints = false
        
        dividerBottomView.backgroundColor = UIColor.black
        dividerBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
 
    private func setupBottomDivider() {
        dividerBottomView.isHidden = !hasBottomDivider
    }


}

extension ButtonView {
    private func setupUI(title: String) {
        titleLabel.font  = .get(font: .regular(size: 15))
        titleLabel.textColor = .black
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        titleLabel.attributedText = NSMutableAttributedString(string: title,
                                                              attributes: [NSAttributedString.Key.kern: -0.41,
                                                                           NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
