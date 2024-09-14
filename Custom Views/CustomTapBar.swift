import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize tab bar items
        if let tabBarItems = tabBar.items {
            for item in tabBarItems {
                if let title = item.title {
                    let unselectedImageName = title
                    let selectedImageName = title + "Selected"
                    
                    let unselectedImage = UIImage(named: unselectedImageName)?.withRenderingMode(.alwaysOriginal)
                    let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
                    
                    // Resize images
                    item.image = resizeImage(unselectedImage, to: CGSize(width: 20, height: 20))
                    item.selectedImage = resizeImage(selectedImage, to: CGSize(width: 20, height: 20))
                    
                    // Adjust title attributes
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 12),
                        .foregroundColor: UIColor.gray
                    ]
                    
                    let selectedAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 12),
                        .foregroundColor: UIColor.customPink
                    ]
                    
                    item.setTitleTextAttributes(attributes, for: .normal)
                    item.setTitleTextAttributes(selectedAttributes, for: .selected)
                }
            }
        }
        
        tabBar.layer.cornerRadius = tabBar.bounds.height / 2
        tabBar.clipsToBounds = true
    }
    
    private func resizeImage(_ image: UIImage?, to size: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
