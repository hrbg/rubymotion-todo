class GradientCell < UITableViewCell

  attr_accessor :delegate
  attr_accessor :toDoItem

  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super(style, reuseIdentifier: reuseIdentifier)

    self.gradientLayer.frame = self.bounds
    
    color1 = UIColor.alloc.initWithWhite(1.0, alpha: 0.2)
    color2 = UIColor.alloc.initWithWhite(1.0, alpha: 0.1)
    color3 = UIColor.clearColor
    color4 = UIColor.alloc.initWithWhite(0.0, alpha: 0.1)
    
    self.gradientLayer.colors    = [color1, color2, color3, color4]
    self.gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
    
    self.layer.insertSublayer(gradientLayer, atIndex: 0)

    recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self, action: "handlePan:")
    recognizer.delegate = self
    addGestureRecognizer(recognizer)

    self
  end

  def gradientLayer
    @originalCenter = CGPoint.new
    deleteOnDragRelease = false

    CAGradientLayer.layer
  end

  def layoutSubviews
    super
    gradientLayer.frame = self.bounds
  end

  def handlePan(recognizer)

    if(recognizer.state == UIGestureRecognizerStateBegan)
      # // when the gesture begins, record the current center location
      @originalCenter = self.center
    end

    if(recognizer.state == UIGestureRecognizerStateChanged)
      translation = recognizer.translationInView(self.superview)
      self.center = CGPointMake(@originalCenter.x + translation.x, @originalCenter.y)
      @deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
      
    end
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
      originalFrame = [[0, frame.origin.y], [bounds.size.width, bounds.size.height]]
      if @deleteOnDragRelease
        if delegate != nil && toDoItem != nil
          delegate.toDoItemDeleted(toDoItem)
          # UIView.animateWithDuration(0.2, animations: lambda {self.frame = originalFrame})
        end
      end
    end
  end

  def gestureRecognizerShouldBegin(gestureRecognizer)
    if (panGestureRecognizer = gestureRecognizer)
      translation = panGestureRecognizer.translationInView(self.superview)

      translation.x.abs > translation.y.abs 
    end
  end
end
