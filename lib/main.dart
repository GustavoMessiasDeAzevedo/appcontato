import 'package:appcontato/lista_contatos.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meus Contatos",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        )
      ),
      home: ListaContatos(),
    )
  );
}
