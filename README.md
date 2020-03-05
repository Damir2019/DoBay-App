# DoBay-App
To do list mini project written with Objective-C

<img src=screenShots/main.png width=200> <img src=screenShots/edit.png width=200> <img src=screenShots/add.png width=200> <img src=screenShots/elete.png width=200>

Explain:
To understant the basics of Objectiv-C language i created a simple application of todo list items.

The application has basic UI UX elements.

At starting the app there is already data inside.
There is a navigationController, two barButtonItems, and a tableView.

There are items and they are orderd by sections.

Tapping on the add barButtonItem shows an AlertController, there you can add the item to a category.
Tapping on Cancel dismissing the AlertController, 
tapping on Add runs a function that check if the fields are empty, and if the section exists, if it does than adds the item to the spesific section, if not adds the item by creating a new section that added to the tableView right away.

tapping on the Edit BarButtonItem toggles the edit style of the tavleView, and there you can press than slide left the item you want to delete.
tapping on it again close the edditing session.

also at normal state you can slide left to delete a selected item.

while deleting the item, the system check if there are more items in that section, if there are only the item selected gets deleted, if not than the item and the section gets deleted.

tapping on each item change the item as checked, tapping again unchecking the item.

the data is not persisted to the mobile phone, this project is only a demo in Objective-C.

