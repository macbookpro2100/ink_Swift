//
//
//  Copyright (c) 2014 - 2016 Pinglin Tang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import SwiftyJSON


class SubtitleTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class JsonViewController: UITableViewController {

    var json: JSON = JSON.null

    // MARK: - Table view data source

    override func viewDidLoad() {

        self.tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "JSONCell")
        title = "SwiftyJSON(\(json.type))"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.json.type {
        case .array, .dictionary:
            return self.json.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JSONCell", for: indexPath)
        let row = indexPath.row

        switch self.json.type {
        case .array:
            cell.textLabel?.text = "\(row)"
            cell.detailTextLabel?.text = self.json.arrayValue.description
        case .dictionary:
            let key: Any = Array(self.json.dictionaryValue.keys)[row]
            let value = self.json[key as! String]
            cell.textLabel?.text = "\(key)"
            cell.detailTextLabel?.text = value.description
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = self.json.description
        }

        cell.accessoryType = .disclosureIndicator

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextController = JsonViewController.init()
        let row = indexPath.row
        var nextJson: JSON = JSON.null
        switch self.json.type {
        case .array:
            nextJson = self.json[row]
        case .dictionary where row < self.json.dictionaryValue.count:
//            let key = Array(self.json.dictionaryValue.keys)[row]
            let cell = tableView .cellForRow(at: indexPath)
            let key = cell?.textLabel?.text
            nextJson = self.json[key as! String]
        default:
            
            return
        }
        nextController.json = nextJson
        print(nextJson)
        self.navigationController?.pushViewController(nextController, animated: true)
    }

    // MARK: - Navigation

}
