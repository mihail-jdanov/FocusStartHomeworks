//
//  DetailViewController.swift
//  Homework4
//
//  Created by Михаил Жданов on 07.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    
    func detailViewControllerNeedsArticle()
    func detailViewControllerDidAppear()
    func detailViewControllerWillDisappear()
    
}

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: DetailViewControllerDelegate?
    
    private var isArticleShown = false
    
    // MARK: - Views
    
    private var detailView: DetailView? {
        return view as? DetailView
    }
    
    // MARK: - Life cycle

    override func loadView() {
        view = DetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.frame = UIScreen.main.bounds
        askForArticleIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate?.detailViewControllerDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.detailViewControllerWillDisappear()
    }
    
    // MARK: - Private methods
    
    private func askForArticleIfNeeded() {
        if !isArticleShown {
            delegate?.detailViewControllerNeedsArticle()
        }
    }
    
    private func showArticle(withIndex index: Int) {
        isArticleShown = true
        let article = ArticlesProvider().articles[index]
        title = article.title
        let firstImage = UIImage(named: article.firstImageName)
        let secondImage = UIImage(named: article.secondImageName)
        detailView?.configure(
            withDescription: article.description ?? article.defaultDescription,
            firstImage: firstImage,
            secondImage: secondImage
        )
    }
    
}

extension DetailViewController: MasterViewControllerDelegate {
    
    // MARK: MasterViewControllerDelegate methods
    
    func masterViewControllerDidSelectArticle(withIndex index: Int) {
        showArticle(withIndex: index)
    }
    
}
