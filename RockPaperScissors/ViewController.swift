//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Emmett Hasley on 1/25/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var paperLong: UILongPressGestureRecognizer!
    @IBOutlet var scissorsLong: UILongPressGestureRecognizer!
    @IBOutlet var rockLong: UILongPressGestureRecognizer!
    @IBOutlet var scissorDouble: UITapGestureRecognizer!
    @IBOutlet var paperDouble: UITapGestureRecognizer!
    @IBOutlet var rockDouble: UITapGestureRecognizer!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var paperImage: UIImageView!
    @IBOutlet weak var scissorsImage: UIImageView!
    @IBOutlet var rockTap: UITapGestureRecognizer!
    @IBOutlet var paperTap: UITapGestureRecognizer!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var p2Image: UIImageView!
    @IBOutlet var scissorsTap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rockImage.image = UIImage(named: "rock")
        paperImage.image = UIImage(named: "paper")
        scissorsImage.image = UIImage(named: "scissors")
        timerLabel.text = "\(seconds)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    enum Selection {
        case rock, paper, scissors
    }
    var choices = [Selection.rock, .paper, .scissors]
    var current : Selection?
    var selected = false
    var timer = Timer()
    var seconds = 3
    var isTimerRunning = false
    var didRush = false
    var lawrence = 0
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            seconds = 3
            isTimerRunning = false
            timerLabel.text = "\(seconds)"
            if didRush == false {
                if playerImage.image != nil {
                    let p2selection = choices.randomElement()
                    switch p2selection {
                    case .rock? :
                        p2Image.image = rockImage.image
                        switch current {
                        case .rock? :
                            tie()
                        case .paper?:
                            win()
                        case .scissors? :
                            lose()
                        case .none:
                            break
                        }
                    case .none:
                        break
                    case .some(.paper):
                        p2Image.image = paperImage.image
                        switch current {
                        case .rock? :
                            lose()
                        case .paper? :
                            tie()
                        case .scissors? :
                            win()
                        case .none:
                            break
                        }
                    case .some(.scissors):
                        p2Image.image = scissorsImage.image
                        switch current{
                        case .rock? :
                            win()
                        case .paper? :
                            lose()
                        case .scissors? :
                            tie()
                        case .none:
                            break
                        }
                    }
                } else {
                    let p2selection = choices.randomElement()
                    switch p2selection {
                    case .rock? :
                        p2Image.image = rockImage.image
                        lose()
                    case .none:
                        break
                    case .some(.paper):
                        p2Image.image = paperImage.image
                        lose()
                    case .some(.scissors):
                        p2Image.image = scissorsImage.image
                        lose()
                    }
                }
            }
        } else {
            seconds -= 1     //This will decrement(count down)the seconds.
            timerLabel.text = "\(seconds)" //This will update the label.
        }
    }
    @IBAction func whenRock(_ sender: Any) {
        if isTimerRunning {
            playerImage.image = rockImage.image
            current = .rock
            selected = true
        }
    }
    @IBAction func whenPaper(_ sender: Any) {
        if isTimerRunning{
            playerImage.image = paperImage.image
            current = .paper
            selected = true
        }
    }
    @IBAction func whenScissor(_ sender: Any) {
        if isTimerRunning {
            playerImage.image = scissorsImage.image
            current = .scissors
            selected = true
        }
    }
    @IBAction func whenStart(_ sender: Any) {
        didRush = false
        if isTimerRunning {
            
        } else {
            runTimer()
            isTimerRunning = true
        }
        if playerImage.image != nil {
            didRush = true
            seconds = 0
            let p2selection = choices.randomElement()
            switch p2selection {
            case .rock? :
                p2Image.image = rockImage.image
                switch current {
                case .rock? :
                    tie()
                case .paper?:
                    win()
                case .scissors? :
                    lose()
                case .none:
                    break
                }
            case .none:
                break
            case .some(.paper):
                p2Image.image = paperImage.image
                switch current {
                case .rock? :
                    lose()
                case .paper? :
                    tie()
                case .scissors? :
                    win()
                case .none:
                    break
                }
            case .some(.scissors):
                p2Image.image = scissorsImage.image
                switch current{
                case .rock? :
                    win()
                case .paper? :
                    lose()
                case .scissors? :
                    tie()
                case .none:
                    break
                }
            }
        }
    }
    func win() {
        let winAlert = UIAlertController(title: "You Win!", message: "Play again?", preferredStyle: .alert)
        let alrightAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.playerImage.image = nil; self.p2Image.image = nil})
        winAlert.addAction(alrightAction)
        present(winAlert, animated: false, completion: nil)
    }
    func lose() {
        let loseAlert = UIAlertController(title: "You Lose!", message: "Bummer", preferredStyle: .alert)
        let alrightAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.playerImage.image = nil; self.p2Image.image = nil})
        loseAlert.addAction(alrightAction)
        present(loseAlert, animated: false, completion: nil)
    }
    func tie() {
        let tieAlert = UIAlertController(title: "You Tied", message: "Go again!", preferredStyle: .alert)
        let alrightAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.playerImage.image = nil; self.p2Image.image = nil})
        tieAlert.addAction(alrightAction)
        present(tieAlert, animated: false, completion: nil)
    }
    @IBAction func whenRules(_ sender: Any) {
        if let url = URL(string: "https://en.wikipedia.org/wiki/Rock%E2%80%93paper%E2%80%93scissors") {
            let safariView = SFSafariViewController(url: url)
            present(safariView, animated: true, completion: nil)
        }
    }
    @IBAction func whenRockDoubled(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        lawrence = 0
        present(imagePicker, animated: true)
    }
    @IBAction func whenPaperDoubled(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        lawrence = 1
        present(imagePicker, animated: true)
    }
    @IBAction func whenScissorDoubled(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        lawrence = 2
        present(imagePicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            var images = [rockImage, paperImage, scissorsImage]
            images[lawrence]!.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func whenRockLonged(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        lawrence = 0
        present(imagePicker, animated: true)
    }
    @IBAction func whenPaperLong(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        lawrence = 1
        present(imagePicker, animated: true)
    }
    @IBAction func whenScissorsLong(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        lawrence = 2
        present(imagePicker, animated: true)
    }
}


