class AppDelegate
  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.rootViewController = main_view_controller
    window.makeKeyAndVisible
    true
  end

  def main_view_controller
    @main_view_controller ||= MainViewController.alloc.initWithNibName(nil, bundle: nil)
  end
  
end
