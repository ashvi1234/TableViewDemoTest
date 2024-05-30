//
//  ViewController.swift
//  TableViewDemoTest
//
//  Created by Ashwini Apurkar on 29/05/24.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]()
    private var currentPage = 1
    private let limit = 10
    private var isFetching = false
    
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    private func fetchPosts() {
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        guard !isFetching else { return }
        isFetching = true
        PostModel.shared.fetchPosts(page: currentPage, limit: limit) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newPosts):
                    self.posts.append(contentsOf: newPosts)
                    self.tableView.reloadData()
                    self.currentPage += 1
                    self.isFetching = false
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                case .failure(let error):
                    print("Failed to fetch posts: \(error)")
                    self.isFetching = false
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
            fetchPosts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        detailVC.post = posts[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension ViewController {
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
}
