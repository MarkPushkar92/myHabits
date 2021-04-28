//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 01.03.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "brightGray")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.toAutoLayout()
        return collectionView
    }()
    
   
    
    @objc func addNewHabit() {
        print(#function)
        let habitViewController = HabitViewController()
        let navi = UINavigationController(rootViewController: habitViewController)
        habitViewController.habitAdded = { self.collectionView.reloadData() }
        present(navi, animated: true, completion: nil)
    }
    
    
//MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHabit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "appPurple")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(collectionView)

        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionView.reloadData()
    }
   
}

//MARK: EXTENSIONS

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
            let progressFloat = HabitsStore.shared.todayProgress
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            cell.progressBar.setProgress(progressFloat, animated: true)
            cell.percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.habit = HabitsStore.shared.habits[indexPath.item]
            return cell
        }
    }
}
