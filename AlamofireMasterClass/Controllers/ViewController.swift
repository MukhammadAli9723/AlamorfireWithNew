//
//  ViewController.swift
//  AlamofireMasterClass
//
//  Created by Muhammadali Yulbarsbekov on 21/02/22.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

let baseURL = "https://inshortsapi.vercel.app/news?category="



class ViewController: UIViewController {
    
    var newsData = [NewsModel]()
    weak var fetchCollectionView: UICollectionView!
    weak var segmentOfFetch:     UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getNews(category: "business")
    }
    func initView(){
        
        let segmentOfFetch = UISegmentedControl (items: ["business","sport","world"])
        segmentOfFetch.selectedSegmentIndex = 0
        view.addSubview(segmentOfFetch)
        segmentOfFetch.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.1)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        segmentOfFetch.addTarget(self, action: #selector(changeNews), for: .valueChanged)
        self.segmentOfFetch = segmentOfFetch
        
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let fetchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(fetchCollectionView)
        fetchCollectionView.showsVerticalScrollIndicator = false
        fetchCollectionView.register(CellOfFetchData.self, forCellWithReuseIdentifier: "cell")
        fetchCollectionView.delegate = self
        fetchCollectionView.dataSource = self
        fetchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentOfFetch.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.7)
        }
        self.fetchCollectionView = fetchCollectionView
        
    }
    
    
    func getNews(category: String){
        
        AF.request(baseURL + category).responseDecodable(of: NewsResponseModel.self) { res in
            guard let data = res.value else { return }
            self.newsData = data.data
            self.fetchCollectionView.reloadData()
        }
    }
    
    
    @objc func changeNews(sender: UISegmentedControl) {
        getNews(category: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "all")
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellOfFetchData
         
        cell.setItem(item: newsData[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 200)
    }
    
    
    
    
}
