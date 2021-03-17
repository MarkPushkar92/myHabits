//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 14.03.2021.
//

protocol HabitDetailsDelegate: class {
    func closeVCFromAnotherVC()
}

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "brightGray")
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        return tableView
    }()
    
    lazy var constraints = [
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ]
    
    
//    @objc func moveToHabit() {
//        guard habit != nil else { return }
//        let rvc = HabitViewController()
//        let navi = UINavigationController(rootViewController: rvc)
//        rvc.delegate = self
//        rvc.existingHabit = habit!
//        rvc.modalTransitionStyle = .flipHorizontal
//        rvc.someCompletion = {
//            self.viewWillAppear(true)
//        }
//        present(navi, animated: true, completion: nil)
//
//    }
//

    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "appPurple")
    
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "appPurple")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(moveToHabit))
        view.backgroundColor = UIColor(named: "brightGray")
        view.addSubview(tableView)
        NSLayoutConstraint.activate(constraints)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard habit != nil else { return }
        let index = HabitsStore.shared.habits.firstIndex(where: {$0 == self.habit!})
        title = HabitsStore.shared.habits[index!].name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "appPurple")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     //   navigationController?.navigationBar.prefersLargeTitles = true

    }
    
}
    
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self), for: indexPath) as! HabitDetailsTableViewCell
        
        let sortedDates = HabitsStore.shared.dates.sorted(by: >)
        let date = sortedDates[indexPath.item]
     
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: HabitsStore.shared.dates.count - 1 - indexPath.item)

        guard HabitsStore.shared.habit(habit!, isTrackedIn: date) else { return cell }
        cell.accessoryType = .checkmark
        
        return cell
    }
}

extension HabitDetailsViewController: HabitDetailsDelegate {
    func closeVCFromAnotherVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
