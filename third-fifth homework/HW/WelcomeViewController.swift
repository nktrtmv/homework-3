//
//  ViewController.swift
//  HW
//
//  Created by Никита Артемов on 05.10.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let generator = UIImpactFeedbackGenerator(style: .light)
    private let incrementButton = UIButton()
    private let valueLabel = UILabel()
    private let commentLabel = UILabel()
    private let colorPaletteView = ColorPaletteView()
    private let buttonColorPaletteView = ColorPaletteView()
    internal let notesViewController = NotesViewController()
    private var newsListController = NewsListViewController()
    private var buttonsSV = UIStackView()
    private var commentView: UIView?
    private var value: Int = 0
    private var flag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        commentView = setupCommentView()
        updateCommentLabel(value: 1)
        setupMenuButtons()
        setupColorControlSV()
        setupButtonColorControlSV()
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
        buttonColorPaletteView.addTarget(self, action: #selector(changeButtonsColor), for: .touchDragInside)
    }

    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        view.addSubview(valueLabel)
        valueLabel.pinButton(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: view.centerXAnchor)
    }

    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        incrementButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        incrementButton.layer.shadowOpacity = 1.0
        incrementButton.layer.shadowRadius = 10.0
        incrementButton.layer.masksToBounds = false
        incrementButton.layer.applyShadow()

        view.addSubview(incrementButton)

        incrementButton.setHeight(48)
        incrementButton.pinTop(to: view.centerYAnchor)
        incrementButton.pin(to: view, [.left: 24, .right: 24])

        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }

    private func setupCommentView() -> UIView {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 12
        view.addSubview(v)
        v.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        v.pin(to: view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .black;
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        v.addSubview(commentLabel)
        commentLabel.pin(to: v, [.top: 16, .left: 16, .bottom: 16, .right: 16])
        return v;
    }

    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "🗒️")
        let newsButton = makeMenuButton(title: "📰")

        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)

        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)

        newsButton.addTarget(self, action: #selector(newsButtonPressed), for: .touchUpInside)

        let buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        view.addSubview(buttonsSV)
        buttonsSV.pin(to: view, [.left: 24, .right: 24])
        buttonsSV.pinButton(to: view.safeAreaLayoutGuide.bottomAnchor, 24)
        self.buttonsSV = buttonsSV
    }

    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo:
            incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo:
            buttonsSV.topAnchor, constant: -8)
        ])
    }

    private func setupButtonColorControlSV() {
        buttonColorPaletteView.isHidden = true
        view.addSubview(buttonColorPaletteView)
        buttonColorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonColorPaletteView.topAnchor.constraint(equalTo:
            incrementButton.bottomAnchor, constant: 8),
            buttonColorPaletteView.leadingAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonColorPaletteView.trailingAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonColorPaletteView.bottomAnchor.constraint(equalTo:
            buttonsSV.topAnchor, constant: -8)
        ])
    }

    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.layer.applyShadow()
        return button
    }

    private func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "its a good start!"
        case 10...20:
            commentLabel.text = "keep going"
        case 20...30:
            commentLabel.text = "yea?"
        case 30...40:
            commentLabel.text = "yea"
        case 40...50:
            commentLabel.text = "! ! ! ! ! ! ! ! ! "
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        case 100...:
            commentLabel.text = "u are insane!"
        default:
            break
        }
    }

    private func updateUI() {
        valueLabel.text = "\(value)"
        updateCommentLabel(value: value)
        incrementButton.backgroundColor = commentView?.backgroundColor
    }

    @objc
    private func changeButtonsColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            let color = self.incrementButton.backgroundColor
            if ((color?.rgba.redComponent)! + (color?.rgba.greenComponent)! + (color?.rgba.blueComponent)! < 1) {
                self.incrementButton.setTitleColor(.white, for: .normal)
                self.commentLabel.textColor = .white
            } else {
                self.incrementButton.setTitleColor(.black, for: .normal)
                self.commentLabel.textColor = .black
            }
            self.commentView?.backgroundColor = slider.chosenColor
            self.incrementButton.backgroundColor = slider.chosenColor
            self.buttonColorPaletteView.backgroundColor = slider.chosenColor
            self.colorPaletteView.backgroundColor = slider.chosenColor
            self.colorPaletteView.stackView.backgroundColor = slider.chosenColor
            self.buttonColorPaletteView.stackView.backgroundColor = slider.chosenColor
            for i in [0, 1, 2] {
                self.buttonsSV.arrangedSubviews[i].backgroundColor = slider.chosenColor
                self.buttonColorPaletteView.stackView.arrangedSubviews[i].backgroundColor = slider.chosenColor
                self.colorPaletteView.stackView.arrangedSubviews[i].backgroundColor = slider.chosenColor
            }
        }
    }

    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
            if (slider.chosenColor < .darkGray) {
                self.valueLabel.textColor = .white
            } else {
                self.valueLabel.textColor = .black
            }
        }
    }

    @objc
    private func incrementButtonPressed() {
        incrementButton.isEnabled = false
        value += 1
        generator.impactOccurred()

        UIView.transition(with: commentLabel,
                duration: 0.15,
                options: .transitionCrossDissolve,
                animations: { [weak self] in
                    let color = self?.commentView?.backgroundColor
                    self?.updateUI();
                    if ((self?.incrementButton.backgroundColor)! > .systemGray6 || (self?.incrementButton.backgroundColor)! < .darkGray) {
                        self?.incrementButton.backgroundColor = UIColor.lightGray
                    } else {
                        self?.incrementButton.backgroundColor = UIColor(red: (color?.rgba.redComponent)! - 0.2,
                                green: (color?.rgba.greenComponent)! - 0.2, blue: (color?.rgba.blueComponent)! - 0.2, alpha: 1)
                    }
                    self?.incrementButton.backgroundColor = color
                }) {
            completion in
            self.incrementButton.isEnabled = true
        }
    }

    @objc
    private func paletteButtonPressed() {
        if (flag == 0) {
            incrementButton.isEnabled = false
            colorPaletteView.isHidden.toggle()
            commentLabel.text = "Changing background color"
            flag += 1
        } else if (flag == 1) {
            commentLabel.text = "Changing elements color"
            colorPaletteView.isHidden.toggle()
            buttonColorPaletteView.isHidden.toggle()
            flag += 1
        } else {
            updateUI()
            incrementButton.isEnabled = true
            buttonColorPaletteView.isHidden.toggle()
            flag = 0
        }
        generator.impactOccurred()
    }

    @objc
    private func notesButtonPressed() {
        let navigation = UINavigationController(rootViewController: notesViewController)
        present(navigation, animated: true)
        generator.impactOccurred()
    }

    @objc
    private func newsButtonPressed() {
        newsListController = NewsListViewController()
        let navigation = UINavigationController(rootViewController: newsListController)
        present(navigation, animated: true)
        generator.impactOccurred()
    }
}
