import 'package:flutter/material.dart';
import 'package:note_app/models/note_db.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDb.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>NoteDb()),
        ChangeNotifierProvider(create: (context)=> ThemeProvider())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themedata,);
  }
}
