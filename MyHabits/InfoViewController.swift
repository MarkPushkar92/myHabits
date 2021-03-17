//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 01.03.2021.
//

import UIKit

class InfoViewController: UIViewController {

    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Привычка за 21 день"
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let mainText: UILabel = {
        let text = UILabel()
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n \n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n \n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n \n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться. \n \n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n \n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n \n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n \nИсточник: psychbook.ru"
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.lineBreakMode = NSLineBreakMode.byWordWrapping
        text.numberOfLines = 0
        return text
    }()

    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var containerView = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        containerView.addSubview(mainText)
    }
    
    override func viewDidLayoutSubviews() {
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            mainText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ]
        NSLayoutConstraint.activate(constraints)
    }
   

}
