//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 01.03.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
   
    private let layout = UICollectionViewFlowLayout()
    lazy var habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private var habitViewController: HabitViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHabit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "appPurple")
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(habitsCollectionView)
        habitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        habitsCollectionView.backgroundColor = UIColor(named: "brightGray")
        habitsCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        habitsCollectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        habitsCollectionView.delegate = self
        habitsCollectionView.dataSource = self
        
        let constraints = [
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    

    @objc func addNewHabit() {
        print(#function)
        
        habitViewController = HabitViewController()
        
        habitViewController?.habitAdded = { [weak self] in
            self?.habitsCollectionView.reloadData()
        }
        
        guard let viewController = habitViewController else { return }
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
   
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width: CGFloat = collectionView.bounds.width - 32
            return CGSize(width: width, height: 60)
        } else {
            let width: CGFloat = collectionView.bounds.width - 32
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else if section == 1 {
            return UIEdgeInsets(top: 18, left: 16, bottom: 12, right: 16)
        } else {
            return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habit = HabitsStore.shared.habits[indexPath.item]
        let details = HabitDetailsViewController()
        details.habit = habit
        navigationController?.pushViewController(details, animated: true)
    }
    
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section != 0 else { return 1 }
        return HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.habit = HabitsStore.shared.habits[indexPath.item]
            return cell
        }
    }
}
