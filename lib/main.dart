import 'package:flutter/material.dart';
import 'package:prueba_bbdd/custom/configuration.dart';
import 'package:prueba_bbdd/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future <void> main() async {
  //Primero se crea la instancia de supabase. Para usar await se debe usar async, por eso pongo en main en async.
  await Supabase.initialize(
    url: configuration.mSupabaseUrl,
    anonKey: configuration.mSupabaseKey,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
