//
//  PhotoDetailViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    // MARK: - Private Properties

    private let viewModel: PhotoDetailViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        viewModel?.fetchPhotoDetails()
    }

    // MARK: - Initializer

    init(viewModel: PhotoDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        finishInit()
    }

    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
        finishInit()
    }

    private func finishInit() {
        bindElements()
    }

    private func bindElements() {
        viewModel?.state.bind { state in
            DispatchQueue.main.async {
                switch state {
                case .loaded(let photo):
                    print(photo)
                case .loading:
                    print("loading")
                case .error(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
}
