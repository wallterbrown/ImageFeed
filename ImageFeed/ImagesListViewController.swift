//
//  ViewController.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 02.05.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet private var TableViewFeed: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // Mark: меняем статус-бар на светлый
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
extension ImagesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ImagesListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
