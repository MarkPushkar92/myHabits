//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Марк Пушкарь on 04.03.2021.
//

import UIKit


class HabitViewController: UIViewController {
    
    var habitAdded: (() -> Void)?
    
    let scrollView = UIScrollView()
    
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
    
    
    @objc func updateDateField(sender: UIDatePicker) {
        datePickerTextInput.text = formatDateForDisplay(date: sender.date)
    }

    fileprivate func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
        
    }
    
    func setupViews() {
        print(#function)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(textInput)
        scrollView.addSubview(colorLabel)
        scrollView.addSubview(colorButton)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(dateText)
        scrollView.addSubview(datePickerTextInput)
        scrollView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 66),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: textInput.topAnchor, constant: -7),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            textInput.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textInput.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textInput.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: -15),
            
            colorLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            colorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dateText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            dateText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dateText.trailingAnchor.constraint(equalTo: datePickerTextInput.leadingAnchor, constant: -10),
            dateText.widthAnchor.constraint(equalToConstant: 100),
            dateText.heightAnchor.constraint(equalToConstant: 30),
            
            datePickerTextInput.heightAnchor.constraint(equalToConstant: 30),
            datePickerTextInput.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            datePickerTextInput.topAnchor.constraint(equalTo: dateText.topAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateText.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            datePicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        datePicker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
        datePickerTextInput.inputView = datePicker
        
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Создать")
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveBarButton))
        saveButton.tintColor = UIColor(named: "appPurple")
        navItem.rightBarButtonItem = saveButton
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelBarButton))
        cancelButton.tintColor = UIColor(named: "appPurple")
        navItem.leftBarButtonItem = cancelButton
        navBar.setItems([navItem], animated: false)

    }
    
    @objc func saveBarButton() {
        print(#function)
        let newHabit = Habit(name: textInput.text!,
                             date: datePicker.date,
                             color: colorButton.backgroundColor!)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        reloadInputViews()
        
        dismiss(animated: true) { [weak self] in
            self?.habitAdded?()
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
