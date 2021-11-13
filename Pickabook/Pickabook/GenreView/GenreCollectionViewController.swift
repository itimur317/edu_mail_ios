//
//  GenreCollectionViewController.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 04.11.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class GenreCollectionViewController: UICollectionViewController {
    let presenter: GenreCollectionViewPresenter!
    
    init(output: GenreCollectionViewPresenter){
        self.presenter = output
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let size = CGSize(width:(collectionView!.bounds.width - 30) / 2, height: 90)
                layout.itemSize = size
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(collectionView)
    }
}

extension GenreCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.genres.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        
        cell.configure(genre: presenter.genres[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.chosedGenre(genre: presenter.genres[indexPath.row])
    }
}
