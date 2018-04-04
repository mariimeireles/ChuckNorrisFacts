//
//  InitialViewController.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 04/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InitialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: FactViewModel!
    private var invalidTerm: Bool!
    private var emptyResult: Bool!
    
    init(withViewModel viewModel: FactViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "InitialViewController", bundle: Bundle.main)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableAndDisableSearchButton()
        searchButtonTaped()
    }
    

    private func enableAndDisableSearchButton() {
        textField
            .rx.text
            .map { !($0?.isEmpty)! }
            .bind(to: searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func searchButtonTaped() {
        searchButton.rx.tap
        .subscribe(onNext: { [weak self] in self?.searchTerm() })
        .disposed(by: disposeBag)
    }
    
    private func searchTerm() {
        guard let term = textField.text else { return }
        setScreenState(for: term)
    }
    
    private func showActivityIndicator(_ bool: Bool) {
        if bool {
            loadingView.alpha = 0.7
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            activityIndicator.alpha = 1
        } else {
            self.textField.text = nil
            loadingView.alpha = 0
            activityIndicator.alpha = 0
        }
    }

    private func setScreenState(for term: String) {
        viewModel?.search(for: term)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in self?.render(state) })
            .disposed(by: disposeBag)
    }

    private func render(_ state: FactScreenState) {
        switch state {
        case .loading:
            showActivityIndicator(true)
        case let .success(facts):
            showSuccessResult(with: facts)
        case .successWithoutFact:
            showNoResult()
        case let .failure(error):
            showFailure(for: error)
        }
    }
    
    private func showSuccessResult(with facts: [FactModel]) {
        showActivityIndicator(false)
        let factsTableViewController = FactsTableViewController(nibName: "FactsTableViewController", bundle: nil)
        factsTableViewController.facts = facts
        navigationController?.pushViewController(factsTableViewController, animated: false)
    }
    
    private func showNoResult() {
        showActivityIndicator(false)
        let alertController = UIAlertController(title: "Ops! 🔍", message: "We couldn't find a result for your search. Try another fact", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showFailure(for error: FactScreenErrorType) {
        switch error {
        case .connection:
            showConnectionError()
        case .noResults:
            showNoResult()
        case .invalidTerm:
            showInvalidTermError()
        case .serverError:
            showInternalOrServerError()
        case .unknown:
            showInternalOrServerError()
        }
    }
    
    private func showConnectionError() {
        showActivityIndicator(false)
        let alertController = UIAlertController(title: "Ops! 🤖", message: "It seems that your not connected to the internet. Check your connection or try again", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        let settingsAction = UIAlertAction(title: "Check connection", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl)  else { return }
            UIApplication.shared.open(settingsUrl)
        }
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
    }

    
    private func showInvalidTermError() {
        showActivityIndicator(false)
        let alertController = UIAlertController(title: "Ops! 😼", message: "This is not a valid term, try another one", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showInternalOrServerError() {
        showActivityIndicator(false)
        let alertController = UIAlertController(title: "Oh No! 😵", message: "An error occurred please try again later", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    

}
