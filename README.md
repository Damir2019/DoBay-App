# DoBay-App
To do list mini project Written with Objective-C

<img src=screenShots/main.png width=200> <img src=screenShots/edit.png width=200> <img src=screenShots/add.png width=200> <img src=screenShots/elete.png width=200>

Explain:
to understant the basics of Objectiv-C language i created a simple application of todo list items.

the application has basic UI UX elements.

At starting the app there is already data inside.
there is a navigation controller, two bar button items, and a table view.

there are items and they are orderd by sections.

tapping on the add barButtonItem shows an AlertController, there you can att the item to a category.
tapping on cancel dismissing the AlertController, 
tapping on Add runs a function that check if the fields are empty, after that check if the section exists, if it does than adds the item to the spesific section, if not adds the item by creating a new section that added to the table view right away.

tapping on the Edit BarButtonItem toggles the edit style of the tavleView, and there you can press to slide left the item you want to delete.
tapping on it again close the edditing session.

also on normal state you can slide left to delete the item.

while deleting the item, the system check if there are more items in that section, if there are only the item selected gets deleted, if not than the item and the section gets deleted.

tapping on each item change the item as checked.

the data is not persisted to the mobile, this project is only a demo in Objective-C.

