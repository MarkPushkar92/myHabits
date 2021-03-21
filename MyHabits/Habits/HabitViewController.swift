//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 04.03.2021.
//

import UIKit


class HabitViewController: UIViewController {
    
    var habitAdded: (() -> ())?
    
    weak var delegate: HabitDetailsDelegate?
    
    let scrollView = UIScrollView()
    
    let containerView: UIView = {
        let container = UIView()
        container.toAutoLayout()
        return container
    }()
    
    var existingHabit: Habit? {
        didSet {
            textInput.text = existingHabit!.name
            colorButton.backgroundColor = existingHabit!.color
            datePicker.date = existingHabit!.date
            deleteButton.isHidden = false
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "НАЗВАНИЕ"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 1
        return label
    }()
    
    let textInput: UITextField = {
        let input = UITextField()
        input.toAutoLayout()
        input.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        input.textColor = .black
        input.layer.borderWidth = 0
        input.font = .systemFont(ofSize: 13)
        return input
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "ЦВЕТ"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    let colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6235294342, blue: 0.3098039329, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
        button.layer.masksToBounds = true
        return button
    }()
    
    let timeLabel: UILabel = {
        let time = UILabel()
        time.toAutoLayout()
        time.text = "ВРЕМЯ"
        time.textColor = .black
        time.font = .boldSystemFont(ofSize: 13)
        return time
    }()
    
    let dateText: UILabel = {
        let date = UILabel()
        date.text =   "Каждый день в "
        date.toAutoLayout()
        date.font = .systemFont(ofSize: 13)
        date.textColor = .black
        return date
    }()
    
    let datePickerTextInput: UITextField = {
        let txtdata = UITextField()
        txtdata.toAutoLayout()
        txtdata.textColor = UIColor(named: "appPurple")
    
        return txtdata
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.toAutoLayout()
        
        return datePicker
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.toAutoLayout()
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return button
    }()
    
//MARK: DELETEHABBIT
    
    @objc func deleteHabit() {
        guard let _ = existingHabit else { return }
        present(alert, animated: true, completion: nil)
    }
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(existingHabit!.name)\" ?", preferredStyle: .alert)
        alert.addAction(actionCancel)
        alert.addAction(actionDel)
        return alert
    }()
    
    lazy var actionDel = UIAlertAction(title: "Удалить", style: .destructive) { (action: UIAlertAction) in
        guard action.isEnabled else { return }
        HabitsStore.shared.habits = HabitsStore.shared.habits.filter { $0 != self.existingHabit! }
        self.dismiss(animated: true, completion: nil)
        self.delegate?.closeVCFromAnotherVC()
        
    }
    
    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
    
//MARK: FUNC
    
    func setupViews() {
        print(#function)
        scrollView.toAutoLayout()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(textInput)
        containerView.addSubview(colorLabel)
        containerView.addSubview(colorButton)
        containerView.addSubview(timeLabel)
        containerView.addSubview(dateText)
        containerView.addSubview(datePickerTextInput)
        containerView.addSubview(datePicker)
        containerView.addSubview(deleteButton)
        containerView.toAutoLayout()
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: textInput.topAnchor, constant: -7),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            textInput.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textInput.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textInput.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: -15),
            
            colorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            colorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dateText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            dateText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dateText.trailingAnchor.constraint(equalTo: datePickerTextInput.leadingAnchor, constant: -10),
            dateText.widthAnchor.constraint(equalToConstant: 100),
            dateText.heightAnchor.constraint(equalToConstant: 30),
            
            datePickerTextInput.heightAnchor.constraint(equalToConstant: 30),
            datePickerTextInput.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            datePickerTextInput.topAnchor.constraint(equalTo: dateText.topAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateText.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            datePicker.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -32),
            
            deleteButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func navSettings() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = .init(title: "Отменить", style: .plain, target: self, action: #selector(cancelBarButton))
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = UIColor(named: "appPurple")
        navigationController?.navigationBar.topItem?.rightBarButtonItem = .init(title: "Сохранить", style: .plain, target: self, action: #selector(saveBarButton))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor(named: "appPurple")
    }
    
    @objc func saveBarButton() {
        if existingHabit == nil {
            let newHabit = Habit(name: textInput.text!,
                                 date: datePicker.date,
                                 color: colorButton.backgroundColor!)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            dismiss(animated: true, completion: habitAdded)
        }   else {
            existingHabit!.name = textInput.text ?? ""
            existingHabit!.date = datePicker.date
            existingHabit!.color = colorButton.backgroundColor!
            let index = HabitsStore.shared.habits.firstIndex(where: {$0 == existingHabit!})
            HabitsStore.shared.habits[index!] = existingHabit!
            dismiss(animated: true, completion: habitAdded)
        }
    }
    
    @objc func cancelBarButton() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func colorButtonPressed() {
        print(#function)
        let picker = UIColorPickerViewController()
        self.present(picker, animated: true, completion: nil)
        picker.selectedColor = colorButton.backgroundColor!
        picker.delegate = self
    }
    
    @objc func updateDateField(sender: UIDatePicker) {
        datePickerTextInput.text = formatDateForDisplay(date: sender.date)
    }

    func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }

//MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        datePicker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
        datePickerTextInput.inputView = datePicker
        navSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}

//MARK: EXTENSIONS

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
