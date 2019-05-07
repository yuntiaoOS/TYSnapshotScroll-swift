//
//  ViewController.swift
//  TYSnapshotScroll-swift
//
//  Created by ma c on 2019/5/7.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView: UITableView = { [weak self] in

        let cv =  UITableView.init(frame:  CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 100), style: .grouped)

        cv.delegate = self
        cv.dataSource = self

        return cv
        }()

    lazy var scrollerView: UIScrollView = { [weak self] in

        let cv =  UIScrollView.init(frame: CGRect(x: 0, y: 220, width: UIScreen.main.bounds.width, height: 100))

        cv.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        cv.backgroundColor = UIColor.init(white: 0.5, alpha: 1.0)

        let text = UILabel.init(frame: CGRect(x: 120, y: 20, width: 50, height: 1000))
        text.numberOfLines = 0
        text.text = "* Trade-in values will vary based on the condition, year, and configuration of your trade-in device. You must be at least 18 years old to be eligible to trade in for credit or for an Apple Store Gift Card. Not all devices are eligible for credit. More details are available from Apple’s Mac trade‑in partner and Apple’s iPhone, iPad, and Apple Watch trade‑in partner for trade-in and recycling of eligible devices. Restrictions and limitations may apply. Payments are based on the received device matching the description you provided when your estimate was made. Apple reserves the right to refuse or limit the quantity of any device for any reason. In the Apple Store: Offer only available on presentation of a valid, government-issued photo ID (local law may require saving this information). Value of your current device may be applied toward purchase of a new Apple device. Offer may not be available in all stores. Some stores may have additional requirements.Whether you’re a STEM major or studying liberal arts, or even if you’re still undecided, Mac has the power to take on any course load. It’s portable, durable, and versatile enough to handle whatever you love to do after class, too. And it’s designed to grow with you, during your time on campus and beyond. So you’re ready for everything college — and life — have to offer.Mac is built to last. And last. The sturdy aluminum unibody design is sleek, durable, and ready to hold up to the rigors of college life. It’s razor thin and feather light, so no matter where your schedule takes you, Mac can carry you through your day — without having to carry much in your backpack. And with optional AppleCare, you can rest assured that you’re covered if you ever need service or support."
        cv.addSubview(text)
        return cv
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.addSubview(scrollerView)
        self.view.addSubview(tableView)

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        snapshot()
    }

    func snapshot()  {
//        TYSnapshotScroll.screenSnapshot(self.tableView) { (image) in
//            self.xnShare(self, image: image)
//        }

        TYSnapshotScroll.screenSnapshot(self.scrollerView) { (image) in
            self.xnShare(self, image: image)
        }
    }



}

extension UIViewController:UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellForRowAtReuseIdentifier")
        cell.textLabel?.text = "* Trade-in values will vary based on the condition, year, and configuration of your trade-in device. You must be at least 18 years old to be eligible to trade in for credit or for an Apple Store Gift Card. Not all devices are eligible for credit. More details are available from Apple’s Mac trade‑in partner and Apple’s so no matter where your schedule takes you, Mac can carry you through your day — without having to carry much in your backpack. And with optional AppleCare, you can rest assured that you’re covered if you ever need service or support."
        return cell

    }


}

