//
//  OnboardingViewController.swift
//  SeaHerd
//
//  Created by Pasquale Vittoriosi on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles = ["ciao","ciao","ciao"]
    var descriptions = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
    var images = ["","",""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview

        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            
                frame.origin.x = scrollWidth * CGFloat(index)
                frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                let slide = UIView(frame: frame)

                //subviews
                let imageView = UIImageView.init(image: UIImage.init(named: images[index]))
                imageView.frame = CGRect(x:0,y:0,width:300,height:300)
                imageView.contentMode = .scaleAspectFit
                imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
              
                let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
                txt1.textAlignment = .center
                txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
                txt1.text = titles[index]

                let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
                txt2.textAlignment = .center
                txt2.numberOfLines = 3
                txt2.font = UIFont.systemFont(ofSize: 18.0)
                txt2.text = descriptions[index]
            
                if (index == titles.count - 1){
                    let adoptButton = UIButton()
                    adoptButton.frame = CGRect(x:32,y:txt2.frame.maxY+10,width:scrollWidth-64,height:50)
                    adoptButton.backgroundColor = UIColor(hexFromString: "#003D61")
                    adoptButton.setTitle("Adopt a jellyfish", for: .normal)
                    adoptButton.addTarget(self, action: #selector(adoptButtonPressed), for: .touchUpInside)
                    slide.addSubview(adoptButton)
                }

                slide.addSubview(imageView)
                slide.addSubview(txt1)
                slide.addSubview(txt2)
                scrollView.addSubview(slide)

            }

            //set width of scrollview to accomodate all the slides
            scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

            //disable vertical scroll/bounce
            self.scrollView.contentSize.height = 1.0

            //initial state
            pageControl.numberOfPages = titles.count + 1
            pageControl.currentPage = 0
    }
    
    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > (scrollView.contentSize.width - scrollView.frame.size.width)) {
            performSegue(withIdentifier: "ShowTabBar", sender: scrollView)
            
        }
    }
    
    //indicator
    func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage() {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    
    @objc func adoptButtonPressed(sender: UIButton!) {
        performSegue(withIdentifier: "ShowTabBar", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTabBar" {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            if sender is UIButton {
                if let destViewController = segue.destination as? UITabBarController {
                    destViewController.selectedIndex = 1
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
