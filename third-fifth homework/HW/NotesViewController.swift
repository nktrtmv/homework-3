//
// Created by Никита Артемов on 27.10.2022.
//

import Foundation
import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"

    func configure(note: String) {
        textLabel?.text = note
        textLabel?.numberOfLines = 0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    internal var dataSource = [String]()
    private var fileURL: URL = {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return docDir.appendingPathComponent("savedData.txt")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataSource = load()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(_: animated)
        setupView()
    }

    private func setupView() {
        setupTableView()
        setupNavBar()
    }

    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pin(to: view)
    }


    private func setupNavBar() {
        title = "Notes"
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }

    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
        save()
    }

    @objc
    private func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    func save() {
        let d = try! PropertyListEncoder().encode(dataSource)
        try! d.write(to: fileURL, options: [.atomic])
    }

    func load() -> [String] {
        do {
            let d = try Data(contentsOf: fileURL)
            return try PropertyListDecoder().decode([String].self, from: d)
        } catch (_) {
        }
        return []
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
            AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
            NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note: note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
}


extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
        if (indexPath.section != 1) {
            return nil;
        }
        let deleteAction = UIContextualAction(style: .destructive, title: .none) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill",
                withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: String) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
        save()
    }
}



