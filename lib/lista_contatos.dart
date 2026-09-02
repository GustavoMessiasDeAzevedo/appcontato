import 'package:appcontato/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key});

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  List<Map<String, dynamic>> contatos = [];

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  void carregarContatos() async {
    final dados = await DatabaseHelper.buscarContatos();
    setState(() {
      contatos = dados;
    });
  }

  void favoritar(int index) {
    setState(() {
      contatos[index]['favoritos'] = !contatos[index]['favoritos'];
    });
  }

  void adicionarContato() {
    final nomeController = TextEditingController();
    final telefoneController = TextEditingController();
    final siglaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Novo contato"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  hintText: "Digite o nome do contato",
                ),
              ),
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(hintText: "Digite o telefone"),
              ),
              TextField(
                controller: siglaController,
                decoration: InputDecoration(
                  hintText: "Digite a sigla do contato",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                if (telefoneController.text.isNotEmpty &&
                    nomeController.text.isNotEmpty &&
                    siglaController.text.isNotEmpty) {
                  await DatabaseHelper.inserirContatos(
                    siglaController.text,
                    nomeController.text,
                    telefoneController.text,
                  );
                  carregarContatos();

                  Navigator.pop(context);
                }
              },
              child: Text("Adicionar"),
            ),
          ],
        );
      },
    );
  }

  void excluirContato(int index) {
    setState(() {
      contatos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus contatos"), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(12),

        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          final bool favorito = contato['favoritos'] == 0;

          return GestureDetector(
            onLongPress: () => excluirContato(index),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  child: Text(
                    contato['iniciais'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  contato['nome'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  contato['telefone'],
                  style: TextStyle(color: Colors.grey.shade900),
                ),
                trailing: GestureDetector(
                  onTap: () => favoritar(index),
                  child: Icon(
                    Icons.star,
                    color: favorito ? Colors.amber : Colors.grey.shade400,
                    size: 28,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarContato,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
