// Flutter code sample for Drawer from Flutter documentation and modified to show additional features
import 'package:flutter/material.dart'; // import the material package

void main() => runApp(const MyApp()); // the main function to run the app (MyApp is the root widget)

class MyApp extends StatelessWidget { // MyApp is a stateless widget meaning it doesn't maintain any state (doesn't change) (MyApp can be any widget name)
  const MyApp({super.key}); // constructor for MyApp with a key (super.key passes the key to the superclass) key is an identifier for widgets, used by Flutter to differentiate between widgets in the widget tree. So, the key helps Flutter keep track of widgets in the tree.

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
  const MyHomePage({super.key, required this.title}); // to build this page, a title is required which is 'Drawer Demo+' passed from MyApp

  final String title; // this is a property of MyHomePage that holds the title string passed in the constructor. title = 'Drawer Demo+' Basically, it stores the title so it can be used later in the widget. (widget.title to access it in the state class)

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
  // 5: Employee, 6: Student Planning, 7: Course Schedule & Catalog, 8: Grades
  // 9: Graduation Application, 10: Unofficial Transcript, 11: Transfer Summary
  // 12: User Profile, 13: Emergency Information, 14: View/Add Proxy Access
  // 15: Student Records Release (FERPA)
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
    Text('Employee', style: optionStyle), // 5
    Text('Student Planning', style: optionStyle), // 6
    Text('Course Schedule & Catalog', style: optionStyle), // 7
    Text('Grades', style: optionStyle), // 8
    Text('Graduation Application', style: optionStyle), // 9
    Text('Unofficial Transcript', style: optionStyle), // 10
    Text('Transfer Summary', style: optionStyle), // 11
    Text('User Profile', style: optionStyle), // 12
    Text('Emergency Information', style: optionStyle), // 13
    Text('View/Add Proxy Access', style: optionStyle), // 14
    Text('Student Records Release (FERPA)', style: optionStyle), // 15
  ]; 
  // The body (below) will show one of these texts based on the selected index. (ex. _widgetOptions[0] shows "Welcome Home")

  // Titles to show in AppBar for each selected index 
  static const List<String> _titles = <String>[
    'Home', 'Student Finance', 'Financial Aid', 'Tax Information',
    'Banking Information', 'Employee', 'Student Planning', 'Course Schedule & Catalog',
    'Grades', 'Graduation Application', 'Unofficial Transcript', 'Transfer Summary',
    'User Profile', 'Emergency Information', 'View/Add Proxy Access', 'Student Records Release (FERPA)',
  ]; // Matching titles for each screen to show in the app bar
  // AppBar (below) will show one of these titles based on the selected index. (ex. _titles[0] shows "Home")
  
  void _onItemTapped(int index) { // When you tap a drawer item ("Home," "Business," etc.), this function runs.
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); 
  } // setState() is a special method that tells Flutter "Hey, something changed! You need to rebuild the UI." When you call setState(), Flutter will call the build() method again, and the UI will update to reflect the new state.
    // Inside it, _selectedIndex = index; updates which item is selected based on what you tapped. Navigator.pop(context); closes drawer after selection
    // Flutter then re-calls build(), and the screen updates to show the corresponding text.
    // This is how this app actually responds to user interaction.
  
  // Helpers for panels
  bool _panelHasSelection(List<int> indices) => indices.contains(_selectedIndex); // Used by panels (ExpansionTile) to decide whether they should be initially expanded or not. It checks if the current selected index is in the list of indices for that panel. If yes, it returns true (expand the panel); otherwise, false (keep it collapsed).

  @override
  Widget build(BuildContext context) { // Flutter calls build() whenever it needs to redraw this part of the UI (ex. after you tap something and call setState())
    // Groups of indices for each collapsible panel
    const financeGroup = <int>[1, 2, 3, 4];
    const employmentGroup = <int>[5];
    const academicsGroup = <int>[6, 7, 8, 9, 10, 11];
    const userOptionsGroup = <int>[12, 13, 14, 15];
    
    // The structure of Scaffold
    // ──────────────────────────────────────────────────────────────────────────
    // AppBar = Top bar -> Displays the title and menu button on home screen
    // Body = Main content area -> Shows the selected widget based on the drawer item tapped on home screen
    // Drawer = Side menu -> Contains the list of items for navigation
    // ──────────────────────────────────────────────────────────────────────────
    return Scaffold( // Scaffold is the page layout structure from the material library - it gives you an AppBar, Drawer, Body, etc. You can think of it like a basic page template.
     appBar: AppBar(
       title: Text(_titles[_selectedIndex]), // the title in the middle of the app bar (based on the selected index)
       leading: Builder( // leading = the icon/button on the left side of the app bar (usually a back button or menu button)
         builder: (context) { // new context that is a descendant of the Scaffold
           return IconButton(
             icon: const Icon(Icons.menu),
             onPressed: () => Scaffold.of(context).openDrawer(), // opens the drawer when tapped
           );
         },
       ),
     ),

     /*
       AppBar = the top blue bar at the top of the screen
       title: Text(_titles[_selectedIndex]) = this shows the title passed from MyApp ('Drawer Demo') in the app bar
       The menu button (☰) on the left is made with IconButton. When you tap it, it calls Scaffold.of(context).openDrawer(), which opens the drawer panel.
       Builder(
         builder: (context) {...}
       )
       The reason for using Builder(context) is to get a new context that is a descendant of the Scaffold. This is necessary because the original context passed to build() is above the Scaffold in the widget tree, so calling Scaffold.of(context) would not find the Scaffold. By using Builder, we create a new context that is inside the Scaffold, allowing us to access it properly.
       In other words, the Builder(context) is saying "Hey Flutter, please give me a new context that starts inside this part of the widget tree." Then, Flutter looks upward and finds the Scaffold, bc this new context is now below it in the hierarchy.
       Now, when we call Scaffold.of(context).openDrawer(), it works correctly and opens the drawer.
      
     */

     // Body still uses your original _widgetOptions[_selectedIndex]
     body: Center(child: _widgetOptions[_selectedIndex]), // This is what you see on the main screen. It shows one of the three texts ("Home," "Business," or "School") based on the selected index.
     // Center = This just makes sure the text is in the middle of the screen.

     // Technically, the layout of drawer starts from here
     drawer: Drawer( // Drawer = the sliding side panel that comes in from the left. It contains a ListView - a scrollable list(column) of items.
       // shape: RoundedRectangleBorder = This customizes the shape of the drawer. By default, drawers are rectangular with sharp corners. Here, we use RoundedRectangleBorder to give it rounded corners on the right side.
       shape: const RoundedRectangleBorder( // This gives the drawer rounded corners
         borderRadius: BorderRadius.only( // BorderRadius.only = allows you to specify which corners to round
           // Rounds the top-right and bottom-right corners of the drawer
           topRight: Radius.circular(20),
           bottomRight: Radius.circular(20),
         ),
       ),

       // The body of the drawer
       // The structure of the body of the drawer
       // ──────────────────────────────────────────────────────────────────────────
       // SafeArea = Ensures content is not blocked by system UI (like notch, status bar)
       // Column = Vertical layout of drawer content
       //   UserAccountsDrawerHeader = Top part with user info
       //   Expanded = Makes the list of items take up remaining space
       //     ListView = Scrollable list of drawer items
       //   Divider = A line to separate sections
       //   ListTile = Bottom logout button
       // ──────────────────────────────────────────────────────────────────────────
       child: SafeArea( // avoiding notch/status bar areas on phones means "Make sure nothing important is hidden behind the phone's notch or status bar."
         child: Column( // vertical layout of drawer content (header -> menu list -> logout button)
           children: [ // Start of the vertical list of items in the drawer
             // Header
             const UserAccountsDrawerHeader( // This is the top part of the drawer with user info. It has a background color, user name, email, and avatar.
               currentAccountPicture: CircleAvatar(child: Text('S')), // CircleAvatar = circular icon with the letter 'S' inside (for Sihoo)
               // Name and email shown under the avatar
               accountName: Text('Sihoo Kim'),
               accountEmail: Text('sihoo@example.com'),
               // Background decoration with a gradient from dark to light
               decoration: BoxDecoration( // BoxDecoration = allows you to customize the background of the header
                 gradient: LinearGradient( // LinearGradient = creates a gradient effect
                   colors: [Colors.black87, Colors.black54],
                   // Gradient goes from top-left (dark) to bottom-right (light)
                   begin: Alignment.topLeft, 
                   end: Alignment.bottomRight,
                 ),
               ),
             ),

             // Scrollable area of items/panels
             Expanded( // Expanded = This makes the drawer items take up all the remaining space below the header and above the logout button.
               child: ListView( // ListView = a scrollable list of items (like a column that can scroll if it overflows)
                // Important: Remove any padding from the ListView.
                 padding: EdgeInsets.zero, // this removes any default padding (space) at the top of the list. We want the drawer header to go all the way to the top.
                 children: [ 
                   // HOME (always goes to main page)
                   ListTile( // ListTile = a single item in the list with an icon and text
                     leading: const Icon(Icons.home), // leading = icon on the left side (home icon)
                     title: const Text('Home'), // title = text next to the icon
                     selected: _selectedIndex == 0, // selected = highlights this item if it is the currently selected one (index 0 = Home)
                     selectedTileColor: Colors.indigo.withOpacity(0.12), // selectedTileColor = background color when selected (indigo with some transparency)
                     onTap: () => _onItemTapped(0), // When tapped, it calls _onItemTapped(0) to update the selected index and close the drawer
                   ),
                   const Divider(height: 1), // Divider = a horizontal line to separate sections (height: 1 means it's a thin line) So, it's a thin separator line under Home


                   // FINANCIAL INFORMATION panel
                   ExpansionTile( // ExpansionTile = a tile that can expand or collapse to show/hide its children
                     leading: const Icon(Icons.account_balance),
                     title: const Text(
                       'Financial Information',
                       style: TextStyle(fontWeight: FontWeight.w700), // w700 = bold
                     ),
                     initiallyExpanded: _panelHasSelection(financeGroup), // This makes the panel start expanded if any of its items are selected
                     childrenPadding:
                         const EdgeInsets.only(left: 16, bottom: 8),
                     children: [
                       ListTile(
                         title: const Text('Student Finance'),
                         selected: _selectedIndex == 1,
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(1),
                       ),
                       ListTile(
                         title: const Text('Financial Aid'),
                         selected: _selectedIndex == 2,
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(2),
                       ),
                       ListTile(
                         title: const Text('Tax Information'),
                         selected: _selectedIndex == 3,
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(3),
                       ),
                       ListTile(
                         title: const Text('Banking Information'),
                         selected: _selectedIndex == 4,
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(4),
                       ),
                     ],
                   ),


                   // EMPLOYMENT panel
                   ExpansionTile(
                     leading: const Icon(Icons.payments),
                     title: const Text(
                       'Employment',
                       style: TextStyle(fontWeight: FontWeight.w700),
                     ),
                     initiallyExpanded: _panelHasSelection(employmentGroup), // this works bc employmentGroup = [5] and _selectedIndex is 5 when "Employee" is selected
                     childrenPadding:
                         const EdgeInsets.only(left: 16, bottom: 8),
                     children: [
                       ListTile(
                         title: const Text('Employee'),
                         selected: _selectedIndex == 5, // this works bc "Employee" is index 5 in the list
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(5),
                       ),
                     ],
                   ),


                   // ACADEMICS panel
                   ExpansionTile(
                     leading: const Icon(Icons.school),
                     title: const Text(
                       'Academics',
                       style: TextStyle(fontWeight: FontWeight.w700),
                     ),
                     initiallyExpanded: _panelHasSelection(academicsGroup),
                     childrenPadding:
                         const EdgeInsets.only(left: 16, bottom: 8),
                     children: [
                       ListTile(
                         title: const Text('Student Planning'),
                         selected: _selectedIndex == 6,
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(6),
                       ),
                        ListTile(
                          title: const Text('Course Schedule & Catalog'),
                          selected: _selectedIndex == 7,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(7),
                        ),
                        ListTile(
                          title: const Text('Grades'),
                          selected: _selectedIndex == 8,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(8),
                        ),
                        ListTile(
                          title: const Text('Graduation Application'),
                          selected: _selectedIndex == 9,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(9),
                        ),
                        ListTile(
                          title: const Text('Unofficial Transcript'),
                          selected: _selectedIndex == 10,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(10), 
                        ),
                        ListTile(
                          title: const Text('Transfer Summary'),
                          selected: _selectedIndex == 11,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(11),
                        ),
                     ],
                   ),


                   // USER OPTIONS panel
                   ExpansionTile(
                     leading: const Icon(Icons.person),
                     title: const Text(
                       'User Options',
                       style: TextStyle(fontWeight: FontWeight.w700),
                     ),
                     initiallyExpanded: _panelHasSelection(userOptionsGroup),
                     childrenPadding:
                         const EdgeInsets.only(left: 16, bottom: 8),
                     children: [
                       ListTile(
                         title: const Text('User Profile'),
                         selected: _selectedIndex == 12,
                         selectedTileColor:
                             Colors.indigo.withOpacity(0.08),
                         onTap: () => _onItemTapped(12),
                       ),
                        ListTile(
                          title: const Text('Emergency Information'),
                          selected: _selectedIndex == 13,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(13),
                        ),
                        ListTile(
                          title: const Text('View/Add Proxy Access'),
                          selected: _selectedIndex == 14,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(14),
                        ),
                        ListTile(
                          title: const Text('Student Records Release (FERPA)'),
                          selected: _selectedIndex == 15,
                          selectedTileColor:
                              Colors.indigo.withOpacity(0.08),
                          onTap: () => _onItemTapped(15),
                        ),
                     ],
                   ),
                 ],
               ),
             ),

             const Divider(height: 1), // Separator line above the logout button

             // Bottom Logout
             ListTile(
               leading: const Icon(Icons.logout),
               title: const Text('Logout'),
               onTap: () { // When tapped
                 Navigator.pop(context); // Close the drawer first
                 ScaffoldMessenger.of(context).showSnackBar( // Then show a brief message at the bottom. (ScaffoldMessenger = a widget that displays snack bars & showSnackBar() = shows a snack bar)
                   const SnackBar(content: Text('Logged out successfully.')), // SnackBar = a small popup message at the bottom of the screen
                 );
               },
             ),
           ],
         ),
       ),
     ),
   );
  }
}

/*
───────────────────────────────────────────────
Drawer Expansion Behavior (Logic Summary)
───────────────────────────────────────────────
1. When the app starts:
   - _selectedIndex = 0 (default → "Home").
   - All ExpansionTiles (main panels) are collapsed because 
     none of their index groups contain 0.

2. When you tap a main panel (like "Academics" or "User Options"):
   - _selectedIndex does NOT change.
   - The panel simply expands or collapses visually.
   - This behavior is built into Flutter’s ExpansionTile widget
     — no custom logic needed.

3. When you tap a sub-panel (like "Grades"):
   - _onItemTapped(index) runs.
   - It updates _selectedIndex to that sub-panel’s index (e.g. 8).
   - It closes the drawer (Navigator.pop(context)).
   - The main screen updates to show the selected page.

4. When you reopen the drawer:
   - Each main panel checks:
       initiallyExpanded: _panelHasSelection(itsGroup)
   - If _selectedIndex belongs to that panel’s group of indices,
     _panelHasSelection() returns true, so that panel starts expanded.
   - Example:
       _selectedIndex = 8 → "Grades"
       academicsGroup = [6,7,8,9,10,11]
       → "Academics" panel starts open.

5. Result:
   - Clicking main panel = just expand/collapse (UI only).
   - Clicking sub-item = updates state & decides which panel
     opens next time.
   - Drawer always reopens showing the section that contains
     the currently selected sub-item.
───────────────────────────────────────────────
*/
