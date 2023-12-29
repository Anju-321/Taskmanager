import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/Pages/homepage.dart';

import 'package:taskmanager/provider/taskprovider.dart';



void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskProvider()),
         
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:ThemeData.dark(),
       home: const HomePage(),)
        
    ,
  )
  );
}