import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let jsonName = "alternativeIcons"
    }
    
    private lazy var blankViewControllerTransitioningDelegate = BlankViewControllerTransitioningDelegate()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let icons = JSONReader<[Icon]>().loadJson(filename: Constants.jsonName)
        let icon = findIconConfigForDate(icons)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.changeAppIcon(icon?.iconName)
        }
        self.changeAppIcon("IconName3")
    }
    
    private func findIconConfigForDate(_ icons: [Icon]?) -> Icon? {
        icons?.first(where: { icon in
            let todayDate = Date()
            if let startDate = DateConverter.getDate(from: icon.startDate, format: .iconDateFormat),
               let endDate = DateConverter.getDate(from: icon.endDate, format: .iconDateFormat){
                return startDate <= todayDate && endDate >= todayDate
            }
            return false
        })
    }
    
    func changeAppIcon(_ iconName: String?) {
        if UIApplication.shared.supportsAlternateIcons {
            let blankViewController = UIViewController()
            blankViewController.modalPresentationStyle = .custom
            blankViewController.transitioningDelegate = blankViewControllerTransitioningDelegate
            present(blankViewController, animated: false, completion: { [weak self] in
                UIApplication.shared.setAlternateIconName(iconName)
                self?.dismiss(animated: false, completion: nil)
            })
        }
    }
}
