import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class NewReportPage extends StatefulWidget {
  @override
  _NewReportPageState createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  final TextEditingController _tiketController = new TextEditingController();
  final TextEditingController _tanggalController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _pelaporController = new TextEditingController();
  final TextEditingController _alamatController = new TextEditingController();
  final TextEditingController _kejadianController = new TextEditingController();
  final TextEditingController _tindakLanjutController =
      new TextEditingController();

  List _listGender = ["Kominfo Kota Malang", "Irfak Wahyudi","A. Yahya Hudan","Muhammad Andy","Abdullah Winasis","Hendra Danang"];
  String _valGender;
  String urlPhoto;
  bool isPhotoNull;
  bool isChange;
  File _image;
  final picker = ImagePicker();
  bool _load = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  loadOn() => setState(() => _load = true);

  loadOff() => setState(() => _load = false);

  void sendPengajuanMasjid() {
    loadOn();
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    Provider.of<ReportProvider>(context, listen: false).postReport(
      id_user:"8",
      nama_pelapor:_pelaporController.text,
      kejadian: _kejadianController.text,
      lokasi_kejadian:  _alamatController.text,
      petugas: _valGender,
      tanggal: _tanggalController.text,
      tindak_lanjut: _tindakLanjutController.text,
      dokumentasi: _image
    ).then((value) {
      print(value);
      if(value==200){
        Navigator.pop(context);
        print("data berhasil dikirim");
      }
      loadOff();

    });
    print(_image);
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  void initState() {
//    Users users = Provider.of<UsersProvider>(context, listen: false).user;
//    _tiketController.text = users.data.nama;
//    _tanggalController.text = users.data.userCredentials.noTelp;
//    _emailController.text = users.data.userCredentials.email;
//    _pelaporController.text = users.data.alamat;
//    _valGender = users.data.jenisKelamin;
//    String url =
//        Provider.of<UsersProvider>(context, listen: false).user.data.foto;
//    urlPhoto = GlobalConfigUrl.baseUrl + url;
//    isPhotoNull = url.endsWith("storage/images/users/");
    isChange = false;
    super.initState();
  }

  @override
  void dispose() {
    _tiketController.dispose();
    _tanggalController.dispose();
    _emailController.dispose();
    _pelaporController.dispose();
    super.dispose();
  }

  Widget _editField(
      {String title,
      String hint,
      TextInputType type,
      TextEditingController controller,
      bool isEnable,
      bool isMandatory}) {
    return Column(
      children: [
        SizedBox(
          height: SpacingDimens.spacing36,
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: TypographyStyle.mini.merge(
              TextStyle(
                color: PaletteColor.grey60,
              ),
            ),
          ),
        ),
        Container(
          color: isEnable ? Colors.transparent : PaletteColor.grey40,
          child: TextFormField(
            validator: isMandatory
                ? (value) {
                    if (value.isEmpty) {
                      return 'Input tidak Boleh Kosong';
                    }
                    return null;
                  }
                : (value) => null,
            enabled: isEnable,
            controller: controller,
            cursorColor: PaletteColor.primary,
            keyboardType: type,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: SpacingDimens.spacing16,
                top: SpacingDimens.spacing8,
                bottom: SpacingDimens.spacing8,
              ),
              hintText: hint,
              hintStyle: TypographyStyle.paragraph.merge(
                TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PaletteColor.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? Container(
            color: Colors.black26,
            width: double.infinity,
            height: double.infinity,
            child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(
                child: indicatorLoad(),
              ),
            ),
          )
        : Container();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Report Page',
              style: TypographyStyle.subtitle0.merge(
                TextStyle(color: PaletteColor.primarybg),
              ),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SpacingDimens.spacing16,
              horizontal: SpacingDimens.spacing24,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tambah Gambar",
                      style: TypographyStyle.caption.merge(
                        TextStyle(
                          color: PaletteColor.grey60,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        child: _image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                    _editField(
                      title: "Tanggal",
                      hint: "Masukkan No. Telepon",
                      type: TextInputType.number,
                      controller: _tanggalController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Kejadian",
                      hint: "Masukkan Kejadian",
                      type: TextInputType.text,
                      controller: _kejadianController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing36,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Nama Petugas",
                        style: TypographyStyle.mini.merge(
                          TextStyle(
                            color: PaletteColor.grey60,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text("Nama Petugas"),
                        value: _valGender,
                        items: _listGender.map(
                          (e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _valGender = value;
                          });
                        },
                      ),
                    ),

                    _editField(
                      title: "Nama Pelapor",
                      hint: "Masukkan Nama Pelapor",
                      type: TextInputType.name,
                      controller: _pelaporController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Tindak Lanjut",
                      hint: "Masukkan Tindak Lanjut",
                      type: TextInputType.text,
                      controller: _tindakLanjutController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Alamat",
                      hint: "Masukkan Alamat",
                      type: TextInputType.streetAddress,
                      controller: _alamatController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: PaletteColor.primary,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
//                          uploadProfile();
                          sendPengajuanMasjid();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: SpacingDimens.spacing48,
                        child: Text(
                          'Tambah Report',
                          style: TypographyStyle.subtitle1.merge(
                            TextStyle(color: PaletteColor.primarybg),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        )
      ],
    );
  }

//  uploadProfile() {
//    loadOn();
//    print("isPhoto null? $isPhotoNull");
//    if (isChange) {
//      Provider.of<UpdateUserProvider>(context, listen: false)
//          .uploadImage(
//        token: Provider.of<UsersProvider>(context, listen: false).token,
//        nama: _tiketController.text,
//        alamat: _pelaporController.text,
//        idUser: Provider.of<UsersProvider>(context, listen: false)
//            .user
//            .data
//            .id
//            .toString(),
//        jenisKelamin: _valGender,
//        noTelp: _tanggalController.text,
//        photo: _image,
//      )
//          .then(
//            (value) {
//          if (value == 200) {
//            var user = Provider.of<UsersProvider>(context, listen: false);
//            user.getUsers(user.user.data.id, user.token);
//            navigatePopUp();
//          }
//          loadOff();
//        },
//      );
//    } else {
//      Provider.of<UpdateUserProvider>(context, listen: false)
//          .updateProfile(
//        token: Provider.of<UsersProvider>(context, listen: false).token,
//        nama: _tiketController.text,
//        alamat: _pelaporController.text,
//        idUser: Provider.of<UsersProvider>(context, listen: false)
//            .user
//            .data
//            .id
//            .toString(),
//        jenisKelamin: _valGender,
//        noTelp: _tanggalController.text,
//      )
//          .then(
//            (value) {
//          if (value == 200) {
//            var user = Provider.of<UsersProvider>(context, listen: false);
//            user.getUsers(user.user.data.id, user.token);
//            navigatePopUp();
//          }
//          print("berhasil");
//          loadOff();
//        },
//      );
//    }
//  }

  void navigatePopUp() {
    Navigator.pop(context);
  }


}
