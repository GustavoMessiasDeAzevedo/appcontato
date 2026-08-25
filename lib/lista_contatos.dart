import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  const ListaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contatos = [
      {
        'iniciais': 'AS',
        'nome': 'Ana Souza',
        'telefone': '(11) 98765-4321',
        'favoritos': true,
        'cor': Colors.red.shade400,
      },
      {
        'iniciais': 'BL',
        'nome': 'Bruno Lima',
        'telefone': '(14) 99123-4567',
        'favoritos': false,
        'cor': Colors.purpleAccent.shade200,
      },
      {
        'iniciais': 'CM',
        'nome': 'Carla Mendes',
        'telefone': '(21) 97654-3210',
        'favoritos': true,
        'cor': Colors.black38,
      },
      {
        'iniciais': 'DA',
        'nome': 'Diego Alves',
        'telefone': '(19) 98888-1234',
        'favoritos': false,
        'cor': Colors.yellow.shade300,
      },
      {
        'iniciais': 'ET',
        'nome': 'Elisa Torres',
        'telefone': '(17) 99999-5678',
        'favoritos': false,
        'cor': Colors.pink.shade300,
      },
      {
        'iniciais': 'GM',
        'nome': 'Gustavo Messias',
        'telefone': '(14) 99903-7062',
        'favoritos': true,
        'cor': Colors.red.shade500,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Meus contatos"), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(12),

        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          final bool favorito = contato['favoritos'];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: contato['cor'],
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
              trailing: Icon(
                Icons.star,
                color: favorito ? Colors.amber : Colors.grey.shade400,
                size: 28,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
