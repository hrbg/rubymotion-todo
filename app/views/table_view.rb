class TableView < UITableView
  
  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    TodoItem.all.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('cell', forIndexPath: indexPath)
    cell.textLabel.text = TodoItem.all[indexPath.row]

    cell
  end
    

end
