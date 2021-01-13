//
//  ViewController.swift
//  JanoneTwelApi
//
//  Created by 황현지 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let originalAddress = "https://api.themoviedb.org/3/movie/now_playing?api_key=b804ea7f3826d58a902a69a0e017708f&language=en-US&page=1"
    var results = [Result]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData() {
        
        let resultUrl = URL(string: originalAddress)
        let request = URLRequest(url: resultUrl!)
        
        //네트워킹1 URLSession
        URLSession.shared.dataTask(with: request) { [self] (data, response, err) in
            print("+++++++++++++", response)
            if err != nil {
                return print("--------err--------", err?.localizedDescription)
            } else {
                results = parseJsonData(sendData: data!)
                
                //테이블뷰 새로고침
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
    
    
    //데이터 파싱 1
    func parseJsonData(sendData: Data) -> [Result] {
        results = [Result]()
        
        do {
            //웹에 있는 자료
            let jsonResult = try JSONSerialization.jsonObject(with: sendData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
            
            let jsonResults = jsonResult["results"] as! [AnyObject]
            
            for jsonResult in jsonResults {
                
                var result = Result()
                result.adult = jsonResult["adult"] as! Bool
                result.average = (jsonResult["vote_average"] as? NSNumber)!.floatValue
                result.overview = jsonResult["overview"] as! String
                result.title = jsonResult["title"] as! String
                
                results.append(result)
            }
            
            
        } catch {
            
            print("---------------", error)
            
        }
        
        return results
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cell1
        
        cell1.adultLabel.text = "\(results[indexPath.row].adult)"
        cell1.averageLabel.text = "\(results[indexPath.row].average)"
        cell1.overviewLabel.text = results[indexPath.row].overview
        cell1.titleLabel.text = results[indexPath.row].title
        
        return cell1
    }
}

