//
//  ViewController.swift
//  pagerView_tutorial
//
//  Created by OCUBE on 2022/12/13.
//

import UIKit
import FSPagerView


class ViewController: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {
    
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg"]
    
    @IBOutlet weak var myPageControl: FSPageControl!{
        didSet{
            //점갯수 설정
            self.myPageControl.numberOfPages = self.imageNames.count
            //점의 위치
            self.myPageControl.contentHorizontalAlignment = .right
            self.myPageControl.itemSpacing = 10
            self.myPageControl.interitemSpacing = 16
        }
        
    }
    @IBOutlet weak var myPagerView: FSPagerView!{
        didSet{
            //페이저뷰에 쎌을 등록한다.
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize
            //무한 스크롤 설정
            self.myPagerView.isInfinite = true
            //자동 스크롤 설정
            self.myPagerView.automaticSlidingInterval = 4.0
        }
        
    }
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        
        self.leftBtn.addTarget(self, action: #selector(leftBtnClicked), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(rightBtnClicked), for: .touchUpInside)
        
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2
        
        
    }
    
    //MARK: - BtnAction
    @objc fileprivate func leftBtnClicked(){
        print("왼쪽버튼이 눌렸다.")
        if self.myPageControl.currentPage == 0{
            self.myPageControl.currentPage = 3
        }else{
            self.myPageControl.currentPage = self.myPageControl.currentPage - 1
        }
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
        
    }
    
    @objc fileprivate func rightBtnClicked(){
        print("오른쪽 버튼이 눌렸다.")
        //오버플로우 현상을 막기위함
        if self.myPageControl.currentPage == self.imageNames.count - 1{
            self.myPageControl.currentPage = 0
        }else{
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
        }
        
        
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
        
    }


    //MARK: - FSPagerView Datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    //각 셀에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            cell.imageView?.image = UIImage(named: self.imageNames[index])
//            cell.textLabel?.text =
            cell.imageView?.contentMode = .scaleAspectFit
            return cell
    }
    
    //MARK: - FSPagerView delegate
    //페이저뷰가 이동이 끝나면 페이지컨트롤의 위치를 바꿔줌
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int){
        self.myPageControl.currentPage = targetIndex
    }
    
    //페이지가 자동으로 넘어갈때 페이지컨트롤도 자동으로 돌아가게 해야함
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    //사진이 클릭이되면 효과를 제거함
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
}

