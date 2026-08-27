import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key});

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final List<Map<String, dynamic>> contatos = [
    {
      'iniciais': 'AS',
      'nome': 'Ana Souza',
      'telefone': '(11) 98765-4321',
      'favoritos': true,
    },
    {
      'iniciais': 'BL',
      'nome': 'Bruno Lima',
      'telefone': '(14) 99123-4567',
      'favoritos': false,
    },
    {
      'iniciais': 'CM',
      'nome': 'Carla Mendes',
      'telefone': '(21) 97654-3210',
      'favoritos': true,
    },
    {
      'iniciais': 'DA',
      'nome': 'Diego Alves',
      'telefone': '(19) 98888-1234',
      'favoritos': false,
    },
    {
      'iniciais': 'ET',
      'nome': 'Elisa Torres',
      'telefone': '(17) 99999-5678',
      'favoritos': false,
    },
    {
      'iniciais': 'GM',
      'nome': 'Gustavo Messias',
      'telefone': '(14) 99903-7062',
      'favoritos': true,
    },
  ];

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
              onPressed: () {
                if (telefoneController.text.isNotEmpty &&
                    nomeController.text.isNotEmpty &&
                    siglaController.text.isNotEmpty) {
                  print("Click");
                  setState(() {
                    contatos.add({
                      'iniciais': siglaController.text,
                      'nome': nomeController.text,
                      'telefone': telefoneController.text,
                      'favoritos': false,
                    });
                  });
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
          final bool favorito = contato['favoritos'];

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
