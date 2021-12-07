//
//  BooksCollectionViewController.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 14.11.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class BooksCollectionViewController: UICollectionViewController {
    let presenter: BooksCollectionViewPresenter!
    let genre: Genre!
    var sortedBooks : [Book]!
    
    init(output: BooksCollectionViewPresenter, genre: Genre){
        self.presenter = output
        self.genre = genre
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.observeBooks(genre: self.genre)
        
        setCollectionView()
        
        presenter.setViewDelegate(delegate: self)
        sortedBooks = presenter.loadBooks(genre: genre)
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func setCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let size = CGSize(width:(collectionView!.bounds.width - 30), height: 100)
        layout.itemSize = size
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView!.register(BookCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func presentNextVC(selectedBook : Book){
        let presenterB = BookViewPresenter()
        let vc = BookProfileViewController(output: presenterB, book: selectedBook)
        self.navigationController?.pushViewController(vc, animated: true)
       
        vc.navigationController?.navigationBar.tintColor = .black
        vc.modalPresentationStyle = .fullScreen
    }
}



extension BooksCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sortedBooks.count
        return self.presenter.currentBooks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCollectionCell
        
//        let book = sortedBooks[indexPath.row]
        let book = self.presenter.currentBooks[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let book = self.presenter.currentBooks[indexPath.row]
           presenter.chosedBook(book: book)
       }
}
