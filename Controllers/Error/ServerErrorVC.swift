import UIKit


class ServerErrorVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "Error")
        
        messageBtn.layer.borderWidth = 1
        messageBtn.layer.borderColor = UIColor.customPink.cgColor
        messageBtn.layer.cornerRadius = 5

    }
    
    @IBAction func callBtnClicked(_ sender: Any) {
    }
    
    @IBAction func messageBtnClicked(_ sender: Any) {
    }
}
