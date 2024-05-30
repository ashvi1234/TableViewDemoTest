//
//  PostDetailViewController.swift
//  TableViewDemoTest
//
//  Created by Ashwini Apurkar on 29/05/24.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var post: Post?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            titleLabel.text = post.title
            bodyLabel.text = post.body
        }
    }
    
}
