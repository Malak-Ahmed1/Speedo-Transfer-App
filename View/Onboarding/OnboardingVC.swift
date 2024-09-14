import UIKit

protocol OnboardingView: AnyObject {
    func updateCurrentPage(_ page: Int)
}

class OnboardingVC: UIViewController, OnboardingView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    private var presenter: OnboardingPresenter!
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            nextBtn.setTitle(presenter.didTapNextButton(currentPage: currentPage) ? "Get Started" : "Next", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OnboardingPresenter(view: self)
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if presenter.didTapNextButton(currentPage: currentPage) {
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            goToRegister()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    @IBAction func skipBtnClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        goToRegister()
    }

    func goToRegister() {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let registerVC = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
    }

    // MARK: - OnboardingView Protocol
    func updateCurrentPage(_ page: Int) {
        currentPage = page
    }
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getSlides().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let slide = presenter.getSlides()[indexPath.row]
        cell.setUp(slide)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let page = Int(scrollView.contentOffset.x / width)
        presenter.didScrollToPage(page)
    }
}
