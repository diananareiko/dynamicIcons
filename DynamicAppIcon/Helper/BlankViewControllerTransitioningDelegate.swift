import UIKit

class BlankViewControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        BlankPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
