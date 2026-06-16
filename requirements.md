# general requirementes
The application shall be installed on current android smartphones. A suitable framework may be chosen for the application, but it can also be a progressive web app. 

Multi-Language support is required via user settings.

Dark theme and light theme are provided according to the user's OS settings.

The app is made for current high resolution screens. Only upright orientation is needed.

The app is opensource under GPL license. Software packages with the same or similar licenses are preferred for the application to ensure the opensource character of the app. 

# functions
The app provides a simple and easy to use shopping list that can be shared between different users. It's functionality is very similar to the [bring app](https://www.getbring.com/) but without additional recipies, advertisment etc.

The app connects to a nextcloud user account and can read a .json file (via an authorisation screen and a file picker - system / standard nextcloud functions can be used) containing the actual list. The list is saved locally and synchronised with the connected nextcloud to enable other users to use the same file for their app.

The .json file contains the actual shopping list items as well as information on how to display the item (icon, order, amount, additional information).

The items are displayed on the screen with three in each row. The list starts with "open" items in a warm red colour. When items are clicked, they are moved town to the "last used" section and the colour changes to a green or turquoise. Tapping an item inthe "last used" sections moves it back to the open section.

A long press on any item opens a dialog to change details of the icon such us icon, amount, additional information.

On the bottom of the screen is a field for inserting text to add new items. While typing, suggestions pop up in a search-as-you-type manner with contents from the "last used" section.

For each item, a simple pictogram is loaded from an opensource library. If no pictogram is found, pictograms are AI-generated in the same style as the previous ones. The user may also regenerate the icons and choose from different Options. The icons are stored in a folder next to the json file and symced in nextcloud. The corresponding icons are referenced by filename in the json.