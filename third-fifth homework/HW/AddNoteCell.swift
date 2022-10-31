//
// Created by Никита Артемов on 27.10.2022.
//

import Foundation

import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: String)
}

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    var delegate: AddNoteDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(140)
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.isEnabled = false
        addButton.alpha = 0.5
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16])
        let cs = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        cs.priority = .defaultHigh
        cs.isActive = true
        contentView.backgroundColor = .systemGray6
    }

    private func clearTextView() {
        textView.selectAll(textView)
        if let range = textView.selectedTextRange {
            textView.replace(range, withText: "")
        }
    }


    @objc
    private func addButtonTapped(_ sender: UIButton) {
        delegate?.newNoteAdded(note: textView.text)
        clearTextView()
    }
}

extension AddNoteCell: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        addButton.isEnabled = !textView.text.isEmpty
        addButton.alpha = addButton.isEnabled ? 0.85 : 0.5
    }
}



