// Flutter code sample for Drawer from Flutter documentation and modified to show additional features
import 'package:flutter/material.dart'; // import the material package

void main() => runApp(const MyApp()); // the main function to run the app (MyApp is the root widget)

class MyApp extends StatelessWidget { // MyApp is a stateless widget meaning it doesn't maintain any state (doesn't change)
  const MyApp({super.key}); // constructor for MyApp with a key (super.key passes the key to the superclass)

  static const appTitle = 'Drawer Demo+'; // a static constant for the app title (static means it belongs to the class, not instances) That title is used in the app bar and the home page

  @override
  Widget build(BuildContext context) { // This is like "Whenever Flutter needs to draw this widget, it calls this build method and asks: 'What should I show right now?'" The 'Widget' is the return type of the method (it returns a widget)
  //(BuildContext is a reference to where you are in the widget tree) With it, you can access theme data, other widgets, etc. and 'context' is the name of that parameter. So, when Flutter calls this method, it will pass in the appropriate context.
    return MaterialApp( // then it returns a MaterialApp widget (the root of the app) => a widget that introduces a number of widgets (like Navigator, Theme) that are commonly required for material design applications.
      title: appTitle,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: appTitle), // MyHomePage is the home screen of the app (home is the default route of the app) and it is stateful (can change)
    );
  }
}

class MyHomePage extends StatefulWidget { // this page can change while the app is running (stateful widget)
  const MyHomePage({super.key, required this.title}); // to build this page, a title is required which is 'Drawer Demo'

  final String title;

  // This is stateful widget, so it needs another object to remember its current state (situation). So, it creates a State object (below) that contains the actual changing stuff. The framework calls createState() when it wants to build the widget.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  /*
    State<MyHomePage> = This means the function will return an object of type State that is linked to MyHomePage. It's like "I'll give you a state manager specifically for MyHomePage."
    createState() = This is a special method every StatefulWidget must have. Flutter calls it automatically when your widget is first created.
    => This is the arrow function syntax in Dart. It's just a shorthand for writing functions that return a single expression. So, instead of writing:
      State<MyHomePage> createState() {
        return _MyHomePageState();
      }
    
    _MyHomePageState() = This creates a new instance of a private class called _MyHomePageState that will actually hold and manage the changing data.
  */
  
}

class _MyHomePageState extends State<MyHomePage> { // Here is the changing-stuff brain for that page. Think of MyHomePage as the container, and _MyHomePageState as the notebook inside it that keeps track of changing information - in this case, which item is selected in the drawer.
  // ──────────────────────────────────────────────────────────────────────────
  // Keep your original state variable and widget list, just expanded.
  // Index map:
  // 0: Home
  // 1: Student Finance, 2: Financial Aid, 3: Tax Information, 4: Banking Information
  // 5: Employment, 6: Academics, 7: User Options
  // ──────────────────────────────────────────────────────────────────────────
  int _selectedIndex = 0; // this variable keeps track of which item is selected in the drawer (0 means the first item is selected by default - which is 'Home')

  static const TextStyle optionStyle = TextStyle( // This sets a text style we can reuse. It says "Make text big (26) and bold." static means it is fixed (doesn't change) and belongs to the class, not instances. That is, all instances of _MyHomePageState share this same optionStyle.
    fontSize: 26,
    fontWeight: FontWeight.bold,
  ); 

  static const List<Widget> _widgetOptions = <Widget>[ // This is a list of screens - each one is a simple Text widget. So, depending on _selectedIndex, one of these three lines of text will appear on screen.
    Text('Welcome Home', style: optionStyle), // index 0
    Text('Student Finance', style: optionStyle), // 1
    Text('Financial Aid', style: optionStyle), // 2
    Text('Tax Information', style: optionStyle), // 3
    Text('Banking Information', style: optionStyle), // 4
    Text('Employment', style: optionStyle), // 5
    Text('Academics', style: optionStyle), // 6
    Text('User Options', style: optionStyle), // 7
  ]; 

  void _onItemTapped(int index) { // When you tap a drawer item ("Home," "Business," etc.), this function runs.
    setState(() {
      _selectedIndex = index;
    });
  } // setState() is a special method that tells Flutter "Hey, something changed! You need to rebuild the UI." When you call setState(), Flutter will call the build() method again, and the UI will update to reflect the new state.
    // Inside it, _selectedIndex = index; updates which item is selected based on what you tapped. Flutter then re-calls build(), and the screen updates to show the corresponding text.
    // This is how this app actually responds to user interaction.

  @override
  Widget build(BuildContext context) { // Flutter calls build() whenever it needs to redraw this part of the UI (ex. after you tap something and call setState())
    return Scaffold( // Scaffold is the page layout structure from the material library - it gives you an AppBar, Drawer, Body, etc. You can think of it like a basic page template.
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) { // new context that is a descendant of the Scaffold
            return IconButton(
              icon: const Icon(Icons.menu), // the menu icon (☰)
              onPressed: () {
                Scaffold.of(context).openDrawer(); // opens the drawer panel
              },
            );
          },
        ),
      ),
      /*
        AppBar = the top blue bar at the top of the screen
        title: Text(widget.title) = this shows the title passed from MyApp ('Drawer Demo') in the app bar
        The menu button (☰) on the left is made with IconButton. When you tap it, it calls Scaffold.of(context).openDrawer(), which opens the drawer panel.
        Builder(
          builder: (context) {...}
        )
        The reason for using Builder(context) is to get a new context that is a descendant of the Scaffold. This is necessary because the original context passed to build() is above the Scaffold in the widget tree, so calling Scaffold.of(context) would not find the Scaffold. By using Builder, we create a new context that is inside the Scaffold, allowing us to access it properly.
        In other words, the Builder(context) is saying "Hey Flutter, please give me a new context that starts inside this part of the widget tree." Then, Flutter looks upward and finds the Scaffold, bc this new context is now below it in the hierarchy. 
        Now, when we call Scaffold.of(context).openDrawer(), it works correctly and opens the drawer.
        
      */
      
      body: Center(child: _widgetOptions[_selectedIndex]),
      // This is what you see on the main screen. It shows one of the three texts ("Home," "Business," or "School") based on the selected index.
      // Center = This just makes sure the text is in the middle of the screen.

      drawer: Drawer( // Drawer = the sliding side panel that comes in from the left. It contains a ListView - a scrollable list(column) of items.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero, // this removes any default padding (space) at the top of the list. We want the drawer header to go all the way to the top.
          children: [ // the items in the drawer

            const DrawerHeader( 
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            /*
              DrawerHeader = The top part of the drawer (special header section).
              It has a blue background and a text label ("Drawer Header").
              Think of it like the title area of the drawer.
            */

            // Each ListTile is a clickable item in the drawer.
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0, // highlights this item if it's selected. Highlighting gives visual feedback to the user about which section they are currently viewing. It's a boolean expression that checks if the current selected index (_selectedIndex) is 0 (the index for "Home"). If it is, selected becomes true, and the ListTile gets highlighted. Flutter's ListTile widget has built-in support for highlighting when selected is true, usually by changing the background color or text style to indicate that this item is active or chosen.
              onTap: () { // Action when you tap this item
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
