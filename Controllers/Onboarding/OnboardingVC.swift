//
//  OnboardingVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 29/08/2024.
//

import UIKit

class OnboardingVC: UIViewController {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide (title: "Amont", description: "Send money fast with simple steps. Create account, Confirmation, Payment. Simple.", image:UIImage(named: "Fast Loading")!),
          OnboardingSlide(title: "Confirmation", description: "Transfer funds instantly to friends and family worldwide, strong shield protecting a money.", image: UIImage(named: "Currency")!),
          OnboardingSlide(title: "Payment", description: "Enjoy peace of mind with our secure platform  Transfer funds instantly to friends.", image: UIImage(named: "Payment")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            goToRegister()
        } else {
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }

    

    @IBAction func skipBtnClicked(_ sender: UIButton) {
        goToRegister()
    }
    func goToRegister() {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let registerVC = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true)
    }
 }
  

extension OnboardingVC : UICollectionViewDelegate,
    UICollectionViewDataSource,
   UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setUp(slides[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width ,height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
         currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
}
