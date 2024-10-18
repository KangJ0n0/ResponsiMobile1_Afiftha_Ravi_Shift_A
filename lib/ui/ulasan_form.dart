import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/bloc/ulasan_bloc.dart';
import 'package:manajemenpariwisata/models/ulasan.dart';
import 'package:manajemenpariwisata/ui/ulasan_page.dart';
import 'package:manajemenpariwisata/widget/warning_dialog.dart';

// ignore: must_be_immutable
class UlasanForm extends StatefulWidget {
  Ulasan? ulasan;
  UlasanForm({Key? key, this.ulasan}) : super(key: key);

  @override
  _UlasanFormState createState() => _UlasanFormState();
}

class _UlasanFormState extends State<UlasanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH ULASAN";
  String tombolSubmit = "SIMPAN";
  final _reviewerTextboxController = TextEditingController();
  final _ratingTextboxController = TextEditingController();
  final _commentsTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  @override
  void dispose() {
    _reviewerTextboxController.dispose();
    _ratingTextboxController.dispose();
    _commentsTextboxController.dispose();
    super.dispose();
  }

  isUpdate() {
    if (widget.ulasan != null) {
      setState(() {
        judul = "UBAH ULASAN";
        tombolSubmit = "UBAH";
        _reviewerTextboxController.text = widget.ulasan!.reviewer!;
        _ratingTextboxController.text = widget.ulasan!.rating.toString();
        _commentsTextboxController.text = widget.ulasan!.comments!;
      });
    } else {
      judul = "TAMBAH ULASAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _reviewerTextField(),
                _ratingTextField(),
                _commentsTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }

  Widget _reviewerTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Reviewer",
        labelStyle: TextStyle(color: Colors.grey[300]),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[600]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _reviewerTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Reviewer harus diisi";
        }
        return null;
      },
      style: TextStyle(color: Colors.grey[300]),
    );
  }

  Widget _ratingTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Rating (1-5)",
        labelStyle: TextStyle(color: Colors.grey[300]),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[600]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _ratingTextboxController,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            int.tryParse(value) == null ||
            int.parse(value) < 1 ||
            int.parse(value) > 5) {
          return "Rating harus diisi dan bernilai antara 1-5";
        }
        return null;
      },
      style: TextStyle(color: Colors.grey[300]),
    );
  }

  Widget _commentsTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Comments",
        labelStyle: TextStyle(color: Colors.grey[300]),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[600]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _commentsTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Comments harus diisi";
        }
        return null;
      },
      style: TextStyle(color: Colors.grey[300]),
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: _isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
            )
          : Text(
              tombolSubmit,
              style: TextStyle(color: Colors.grey[300]),
            ),
      onPressed: _isLoading
          ? null
          : () {
              var validate = _formKey.currentState!.validate();
              if (validate) {
                if (!_isLoading) {
                  if (widget.ulasan != null) {
                    ubah(); // Update review
                  } else {
                    simpan(); // Create new review
                  }
                }
              }
            },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }

  void simpan() {
    // Validate input fields
    if (_reviewerTextboxController.text.isEmpty ||
        _ratingTextboxController.text.isEmpty ||
        _commentsTextboxController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Semua bidang harus diisi",
              ));
      return;
    }

    int? rating;
    try {
      rating = int.parse(_ratingTextboxController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Rating harus berupa angka",
              ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Ulasan newUlasan = Ulasan(id: null);
    newUlasan.reviewer = _reviewerTextboxController.text;
    newUlasan.rating = rating;
    newUlasan.comments = _commentsTextboxController.text;

    UlasanBloc.addUlasan(ulasan: newUlasan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const UlasanPage()));
    }).catchError((error, stackTrace) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    Ulasan updatedUlasan = Ulasan(id: widget.ulasan!.id);
    updatedUlasan.reviewer = _reviewerTextboxController.text;
    updatedUlasan.rating = int.parse(_ratingTextboxController.text);
    updatedUlasan.comments = _commentsTextboxController.text;

    UlasanBloc.updateUlasan(ulasan: updatedUlasan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const UlasanPage()));
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
