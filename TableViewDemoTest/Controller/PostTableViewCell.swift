//
//  PostTableViewCell.swift
//  TableViewDemoTest
//
//  Created by Ashwini Apurkar on 29/05/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with post: Post) {
        titleLabel.text = "\(post.id). \(post.title)"
        // Perform heavy computation and log time
        let timeInterval = ComputationCache.shared.performComputation(for: post.id)
        print("Heavy computation time: \(timeInterval) seconds")
    }
    
}
