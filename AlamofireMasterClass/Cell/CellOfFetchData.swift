//
//  CellOfFetchData.swift
//  AlamofireMasterClass
//
//  Created by Muhammadali Yulbarsbekov on 21/02/22.
//

import UIKit
import Kingfisher

class CellOfFetchData: UICollectionViewCell {
    let label = UILabel()
    let image = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setItem(item: NewsModel) {
        label.text = item.title
        let url = URL(string: item.imageUrl ?? "")
        image.kf.setImage(with: url)

        
    }
    
    func initView(){
        self.backgroundColor = .orange
        self.addSubview(label)
        label.text = "kaka"
        label.textColor = .systemBlue
        label.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).multipliedBy(0.1)
            make.left.equalTo(self.snp.left).inset(20)
        }
        self.addSubview(image)
        image.image = UIImage(named: "screen")
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
        }
        
        
    }
}
