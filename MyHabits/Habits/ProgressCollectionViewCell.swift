//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 10.03.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let  textLabel: UILabel = {
        var label = UILabel()
        label.toAutoLayout()
        label.text = "Все получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var percentLabel: UILabel = {
        var label = UILabel()
        label.toAutoLayout()
        label.text = "\(Int(HabitsStore.shared.todayProgress) * 100)%"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var progressBar: UIProgressView = {
        var progress = UIProgressView(progressViewStyle: .default)
        progress.toAutoLayout()
        progress.trackTintColor = .systemGray
        progress.progressTintColor = .systemPurple
        progress.layer.cornerRadius = 4
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        return progress
    }()
    
    func setupViews() {
        contentView.addSubview(textLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBar)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        let constraints = [
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            textLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -10),
            
            percentLabel.topAnchor.constraint(equalTo: textLabel.topAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.heightAnchor.constraint(equalToConstant: 7)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


