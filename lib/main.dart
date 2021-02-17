import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/example2.dart';
import 'package:theme_provider/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Theme Provider',
            theme: notifier.darkTheme? dark:light,
            home: HomePage(),
          );
        },
        
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Provider"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ThemeNotifier>(
              builder:(context, notifier, child) => SwitchListTile(
                  value: notifier.darkTheme,
                  onChanged: (val){
                  notifier.toggleTheme();
                  },
              title: Text("Dark Mode"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("This is just a list tile on a card."),
              ),
            ),
            
            SizedBox(height: 10.0,),
            
            RaisedButton(
                child: Text("Continue"),
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_)=> Example()));
                })
          ],
        ),
      ),
    );
  }
}
