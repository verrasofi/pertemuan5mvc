import 'package:flutter/material.dart';
import 'PoliModel.dart';
import 'PoliController.dart';
import 'package:provider/provider.dart';

class PoliPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final poliController = Provider.of<PoliController>(context);

    final TextEditingController namaPoliController = TextEditingController();
    final TextEditingController deskripsiPoliController =
        TextEditingController();

    // Fungsi untuk menampilkan dialog konfirmasi hapus
    void _showDeleteConfirmation(String id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus'),
            content: Text('Apakah Anda yakin ingin menghapus data ini?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  poliController.deletePoli(id);
                  Navigator.of(context).pop(); // Tutup dialog setelah hapus
                },
                child: Text('Hapus'),
              ),
            ],
          );
        },
      );
    }

    // Fungsi untuk mengedit data poli
    void _editPoli(Poli poli) {
      namaPoliController.text = poli.namaPoli;
      deskripsiPoliController.text = poli.deskripsiPoli;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Poli'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaPoliController,
                  decoration: InputDecoration(labelText: 'Nama Poli'),
                ),
                TextField(
                  controller: deskripsiPoliController,
                  decoration: InputDecoration(labelText: 'Deskripsi Poli'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (namaPoliController.text.isEmpty ||
                    deskripsiPoliController.text.isEmpty) {
                  // Tampilkan pesan jika ada field kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Nama Poli dan Deskripsi tidak boleh kosong')),
                  );
                  return;
                }

                poliController.updatePoli(
                  poli.id,
                  namaPoliController.text,
                  deskripsiPoliController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Data Poli'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaPoliController,
              decoration: InputDecoration(labelText: 'Nama Poli'),
            ),
            TextField(
              controller: deskripsiPoliController,
              decoration: InputDecoration(labelText: 'Deskripsi Poli'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (namaPoliController.text.isEmpty ||
                    deskripsiPoliController.text.isEmpty) {
                  // Tampilkan pesan jika input kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Nama Poli dan Deskripsi tidak boleh kosong')),
                  );
                  return;
                }

                // Tambah poli baru
                poliController.addPoli(
                  namaPoliController.text,
                  deskripsiPoliController.text,
                  // context,
                );
                namaPoliController.clear();
                deskripsiPoliController.clear();
              },
              child: Text('Tambah Poli'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: poliController.poliList.length,
                itemBuilder: (context, index) {
                  final poli = poliController.poliList[index];
                  return ListTile(
                    title: Text(poli.namaPoli),
                    subtitle: Text(poli.deskripsiPoli),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editPoli(poli),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _showDeleteConfirmation(poli.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
