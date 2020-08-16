

    import UIKit
    
    @IBDesignable
    class DesignableUITextField: UITextField {
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
       
        
      
        
        
        // Provides left padding for images
        override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
        
            textRect.origin.x += leftPadding
          
            return textRect
        }
        
        override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRight = super.rightViewRect(forBounds: bounds)
            
            textRight.origin.x += rightPadding
            
            return textRight
        }
        
        @IBInspectable var leftImage: UIImage? {
            didSet {
                updateView()
            }
            
        }
        
        @IBInspectable var leftPadding: CGFloat = 0
        @IBInspectable var rightPadding: CGFloat = 0
        
        @IBInspectable var color: UIColor = UIColor.white {
            didSet {
                updateView()
            }
        }
        
        func updateView() {
            if let image = leftImage {
                leftViewMode = UITextFieldViewMode.always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
               

                imageView.image = image
                // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
                imageView.tintColor = color
                leftView = imageView
            } else {
                leftViewMode = UITextFieldViewMode.never
                leftView = nil
            }
            
        }
        
       
        
        
}


