class MainViewController < UITableViewController

  def viewDidLoad
    super

    tableView.dataSource = self
    tableView.delegate   = self
    tableView.dataSource = self
    tableView.registerClass(GradientCell, forCellReuseIdentifier: "cell")
    tableView.separatorStyle = 0
    tableView.rowHeight = 50.0
    tableView.backgroundColor = UIColor.blackColor()

  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    TodoItem.all.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel.text = TodoItem.all[indexPath.row]
    cell.textLabel.backgroundColor = UIColor.clearColor
    cell.selectionStyle = 0
    
    cell
  end

 def colorForIndex(index) 
   itemCount = TodoItem.all.count - 1
   val       = (index.to_f / itemCount.to_f) * 0.6
   puts "index : #{index} :: val : #{val}"
   UIColor.alloc.initWithRed(1.0, green: val, blue: 0.0, alpha: 1.0)
 end
 
 def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.backgroundColor = colorForIndex(indexPath.row)
 end
    
end
