import therapist
import cmd/init, cmd/add, cmd/remove, cmd/update, cmd/tag, cmd/list

let initCmd = (
  force: newCountArg(@["-f", "--force"], optional=true, help = "will override an existing project in this folder"),
  help: newHelpArg()
)

let addCmd = (
  item: newStringArg(@["<item>"], help = "name of the item to add"),
  cost: newStringArg(@["<cost>"], help = "cost per interval"),
  interval: newStringArg(@["<interval>"], help = "time interval"),
  tag: newStringArg(@["<tag>"], optional=true, help = "tag"),
  help: newHelpArg()
)

let removeCmd = (
  item: newStringArg(@["<item>"], help = "name of the item to remove"),
  help: newHelpArg()
)

let updateCmd = (
  item: newStringArg(@["<item>"], help = "name of the item to update"),
  field: newStringArg(@["<field>"], choices = @["name","cost","interval"], help = "field to update"),
  value: newStringArg(@["<value>"], help = "value to update to"),
  help: newHelpArg()
)

let tagCmd = (
  item: newStringArg(@["<item>"], help = "name of the item to tag"),
  tag: newStringArg(@["<tag>"], help = "name of the tag to use"),
  help: newHelpArg()
)

let listCmd = (
  more: newCountArg(@["-m", "--more"], optional=true, help = "shows more info"),
  tag: newStringArg(@["<tag>"], optional=true, help = "filter list by tag"),
  help: newHelpArg()
)


let spec = (
  init: newCommandArg(@["init"], initCmd, help = "initialize finance project"),
  add: newCommandArg(@["add"], addCmd, help = "add an item to expenses"),
  remove: newCommandArg(@["remove","delete","del"], removeCmd, help = "remove an item from expenses"),
  update: newCommandArg(@["update","up"], updateCmd, help = "update an item"),
  tag: newCommandArg(@["tag","mark","label"], tagCmd, help = "tag an item with a custom label"),
  list: newCommandArg(@["list","ls","show","display"], listCmd, help = "list all items in expenses"),
)

spec.parseOrHelp()

if spec.init.seen:
  calcInit(force = initCmd.force.seen)
elif spec.add.seen:
  calcAdd(item = addCmd.item.value, cost = addCmd.cost.value, interval = addCmd.interval.value, tag = addCmd.tag.value)
elif spec.remove.seen:
  calcRemove(item = removeCmd.item.value)
elif spec.update.seen:
  calcUpdate(item = updateCmd.item.value, field = updateCmd.field.value, value = updateCmd.value.value)
elif spec.tag.seen:
  calcTag(item = tagCmd.item.value, tag = tagCmd.tag.value)
elif spec.list.seen:
  calcList(more = listCmd.more.seen, tag = listCmd.tag.value)
else:
  # echo spec.render_help()
  echo "test"