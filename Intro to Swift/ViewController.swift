//
//  ViewController.swift
//  Intro to Swift
//
//  Created by Pauline Masigla on 2/27/18.
//  Copyright © 2018 Pauline Masigla. All rights reserved.
//

import UIKit

let flickrApiKey = "51e35c229eb831ee98ec4530983f991c"

class ViewController: UIViewController {

    
    @IBOutlet weak var testPicture: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var testAnswerButton: UIButton!
    
    let flickrUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=51e35c229eb831ee98ec4530983f991c&safe_search=1&content_type=1&media=photos&accuracy=3&per_page=1&page=1&format=json&nojsoncallback=1";
    
    let countries = [
        "Afghanistan",
        "Albania",
        "Algeria",
        "Angola",
        "Argentina",
        "Australia",
        "Austria",
        "The Bahamas",
        "Belgium",
        "Botswana",
        "Brazil",
        "Bulgaria",
        "Canada",
        "Chile",
        "China",
        "Costa Rica",
        "Cuba",
        "Denmark",
        "Dominican Republic",
        "Egypt",
        "Ethiopia",
        "Finland",
        "France",
        "Germany",
        "Greece",
        "Guatemala",
        "Haiti",
        "Hong Kong",
        "Iceland",
        "India",
        "Iran",
        "Iraq",
        "Ireland",
        "Israel",
        "Italy",
        "Jamaica",
        "Japan",
        "Kazakhstan",
        "Kenya",
        "Lebanon",
        "Libya",
        "Mexico",
        "Morocco",
        "Netherlands",
        "New Zealand",
        "North Korea",
        "Norway",
        "Pakistan",
        "Peru",
        "Poland",
        "Portugal",
        "Russia",
        "Rwanda",
        "Spain",
        "South Korea",
        "Sweden",
        "Switzerland",
        "Thailand",
        "Uganda",
        "United Kingdom",
        "United States",
        "Venezuela",
        "Vatican City",
        "Zimbabwe"
    ];
    
    var selectedCountry = "United States";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func handleButton(_ sender: Any) {
        let count = countries.count
        let index = Int(arc4random_uniform(UInt32(count)))
        
        selectedCountry = countries[index]
        
        let searchUrl = createFlickrSearchUrl(selectedCountry);
        
        sendPictureRequest(urlString: searchUrl);
        
        testLabel.text = selectedCountry;
    }
    
    func createFlickrSearchUrl(_ country: String) -> String {
        guard let encodedSearchTerm =
            country.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                print("error");
                return flickrUrl;
        }
        
        return flickrUrl + "&text=\(encodedSearchTerm)";
    }
    
    func sendPictureRequest(urlString: String) -> Void {
        guard let url = URL(string: urlString) else {
            print("Something went wrong");
            return;
        }

        let request = URLRequest(url: url);
        let session = URLSession(configuration: .default);
        
        let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let responseData = data else {
                print("Something went wrong");
                return;
            }
            
            let decoder = JSONDecoder();
            do {
                let photoResponse = try decoder.decode(PhotoResponse.self, from: responseData);
                
                if let imageUrl = photoResponse.photos.photo.first?.imageUrl() {
                    self?.displayImage(from: imageUrl);
                }
            } catch let error {
                print("Error! \(error)");
            }
        };
        
        dataTask.resume();
    }
    
    private func displayImage(from imageUrl: URL) -> Void {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let imageRequest = URLRequest(url: imageUrl)
        let imageTask = session.dataTask(with: imageRequest) { [weak self] (data,
            response, error) in
            guard let imageData = data, error == nil, let image = UIImage(data:
                imageData) else {
                    print("Something went wrong in getting the image.")
                    return }
            
            DispatchQueue.main.async {
                // Display image and change label text to be a question
                self?.testPicture.image = image
                self?.testLabel.text = "Where in the World is This?"
            } }
        imageTask.resume()
    }
}

