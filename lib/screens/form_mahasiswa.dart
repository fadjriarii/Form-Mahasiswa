import 'package:flutter/material.dart';
import '../widgets/buttons.dart';

class FormMahasiswaScreen extends StatefulWidget {
  @override
  _FormMahasiswaScreenState createState() => _FormMahasiswaScreenState();
}

class _FormMahasiswaScreenState extends State<FormMahasiswaScreen> {
  // Controler untuk mengelola input pada textdield
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();
  TextEditingController nilaiUTSController = TextEditingController();
  TextEditingController nilaiUASController = TextEditingController();
  TextEditingController totalNilaiController = TextEditingController();

  //Kunci global untuk mendapatkan referensi ke TextField
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // FocusNode digunakan untuk mengontrol fokus pada TextField
  final FocusNode _nimFocusNode = FocusNode();
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _kelasFocusNode = FocusNode();
  final FocusNode _jurusanFocusNode = FocusNode();
  final FocusNode _nilaiUTSFocusNode = FocusNode();
  final FocusNode _nilaiUASFocusNode = FocusNode();

  // untuk mengontrol apakah formulir aktif atau tidak
  bool _isFormEnabled = false;

  void aktifkanForm() {
    setState(() {
      _isFormEnabled = true;

      // mengosongkan semua input
      nimController.text = '';
      namaController.text = '';
      kelasController.text = '';
      jurusanController.text = '';
      nilaiUTSController.text = '';
      nilaiUASController.text = '';
      totalNilaiController.text = '';

      //memberikan fokus pada textform pertama (nim)
      FocusScope.of(context).requestFocus(_nimFocusNode);
    });
  }

  void nonaktifkanForm() {
    setState(() {
      _isFormEnabled = false;

      // Menonaktifkan semua TextFormField dan menghilangkan fokus
      _nimFocusNode.unfocus();
      _namaFocusNode.unfocus();
      _kelasFocusNode.unfocus();
      _jurusanFocusNode.unfocus();
      _nilaiUTSFocusNode.unfocus();
      _nilaiUASFocusNode.unfocus();
    });
  }

  void bersihkanForm() {
    setState(() {
      //mengosongkan semua input
      nimController.text = '';
      namaController.text = '';
      kelasController.text = '';
      jurusanController.text = '';
      nilaiUTSController.text = '';
      nilaiUASController.text = '';
      totalNilaiController.text = '';
    });
  }

  void hitungTotalNilai() {
    if (nilaiUASController.text.isEmpty || nilaiUTSController.text.isEmpty) {
      _showDialog('eeror', 'Nilai UTS dan UAS harus diisi');
      return;
    }
  
  // konversi nilai UTS ke Integer
    int? nilaiUTS = int.tryParse(nilaiUTSController.text);
    int? nilaiUAS = int.tryParse(nilaiUASController.text);

  // jika konversi gagal, tampilkan pesan error
  if (nilaiUTS == null || nilaiUAS == null) {
    _showDialog('Error', 'Nilai UTS dan UAS harus berupa angka');
    return;
  }

  int total = nilaiUTS + nilaiUAS;
  
  setState(() {
    totalNilaiController.text = total.toString();
  });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            ),
        ],
      ),
    );
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Form Mahasiswa'),
    ),

    body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nimController,
              decoration: InputDecoration(labelText: 'NIM'),
              enabled: _isFormEnabled,
              keyboardType: TextInputType.number,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'NIM harus diisi';
                }
                return null;
              },
              focusNode: _nimFocusNode,
            ),


            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
              enabled: _isFormEnabled,
              keyboardType: TextInputType.text,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Nama harus diisi';
                }
                return null;
              },
              focusNode: _namaFocusNode,
            ),

            TextFormField(
              controller: kelasController,
              decoration: InputDecoration(labelText: 'Kelas'),
              enabled: _isFormEnabled,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Kelas harus diisi';
                }
                return null;
              },
              focusNode: _kelasFocusNode,
            ),


            TextFormField(
              controller: jurusanController,
              decoration: InputDecoration(labelText: 'Jurusan'),
              enabled: _isFormEnabled,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Jurusan harus diisi';
                }
                return null;
              },
              focusNode: _jurusanFocusNode,
            ),

            TextFormField(
              controller: nilaiUTSController,
              decoration: InputDecoration(labelText: 'Nilai UTS'),
              enabled: _isFormEnabled,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Nilai UTS harus diisi';
                }
                return null;
              },
              focusNode: _nilaiUTSFocusNode,
            ),


            TextFormField(
              controller: nilaiUASController,
              decoration: InputDecoration(labelText: 'Nilai UAS'),
              enabled: _isFormEnabled,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Nilai UAS harus diisi';
                }
                return null;
              },
              focusNode: _nilaiUASFocusNode,
            ),

            TextFormField(
              controller: totalNilaiController,
              decoration: InputDecoration(labelText: 'Total Nilai'),
              enabled: false,
            ),


            SizedBox(height: 20),
            CustomButtons(
              onTambahPressed: aktifkanForm,
              onHitungPressed: hitungTotalNilai,
              onKeluarPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ]
        ),
      ),
    ),
  );
}
}