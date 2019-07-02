//
//  SwiftMainViewController.swift
//  MPFrameworkDemo_plugin
//
//  Created by 李砚(EX-LIYAN010) on 7/1/19.
//  Copyright © 2019 macbookpro2100. All rights reserved.
//

import Foundation
import UIKit
import CollectionKit
import SwiftyJSON

class SwiftMainViewController: UIViewController {

    typealias SourceData = (UIViewController.Type, String)

    let collectionView = CollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(collectionView)

        setupcollection()
    }

    func setupcollection() {
        let dataSource = ArrayDataSource<SourceData>(data: [
            (CemoListViewController.self, "open Charts"),
            (SimpleLayoutViewController.self, "open SimpleLayout"),
            (BasicUIScrollViewController.self, "open BasicUIScroll"),
            (HeroMainViewController.self, "open Hero"),
            (CollectionKitExamplesViewController.self, "open CollectionKit"),
            (JsonViewController.self, "open SwiftyJSON"),
            
        ])

        let viewSource = ClosureViewSource { (label: UILabel, data: SourceData, index) in
            label.text = "\(index + 1). \(data.1)"
            label.textAlignment = .center
            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.borderWidth = 0.5
            label.layer.cornerRadius = 5
        }

        let sizeSource = { (i: Int, data: SourceData, size: CGSize) -> CGSize in
            return CGSize(width: size.width, height: 50)
        }

        let examplesProvider = BasicProvider<SourceData, UILabel>(
                dataSource: dataSource,
                viewSource: viewSource,
                sizeSource: sizeSource,
                layout: FlowLayout(lineSpacing: 10)) { (context) in
            let vc = context.data.0.init()
            let vtile = context.data.1
            var boolOne = vtile == "open SwiftyJSON"

            if boolOne {
                var viewController = vc as! JsonViewController
                if let file = Bundle.main.path(forResource: "SwiftyJSONTests", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: file))
                        let json = try JSON(data: data)
                        viewController.json = json
                    } catch {
                        viewController.json = JSON.null
                    }
                } else {
                    viewController.json = JSON.null
                }
            }

            self.navigationController?.pushViewController(vc, animated: true)
        }
        // TODO: Migrate the example to CollectionKit 2.2.0

        collectionView.provider = ComposedProvider(
                layout: FlowLayout(lineSpacing: 10).inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)),
                sections: [examplesProvider]
        )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
