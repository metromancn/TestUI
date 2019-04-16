import UIKit

class ContentOneVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.placeholder = "test"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result: UITableViewCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            result = cell
        } else {
            result = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        result.textLabel?.text = "Row \(indexPath.row)"
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
