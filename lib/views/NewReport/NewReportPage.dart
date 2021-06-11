import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class NewReportPage extends StatefulWidget {
  @override
  _NewReportPageState createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _noTeleponController =
  new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _alamatController = new TextEditingController();

  List _listGender = ["pria", "wanita"];
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

  @override
  void initState() {
//    Users users = Provider.of<UsersProvider>(context, listen: false).user;
//    _nameController.text = users.data.nama;
//    _noTeleponController.text = users.data.userCredentials.noTelp;
//    _emailController.text = users.data.userCredentials.email;
//    _alamatController.text = users.data.alamat;
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
    _nameController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
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
              'Profle Page',
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
                      "Profile",
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
//                    GestureDetector(
//                      onTap: () => _showPicker(context),
//                      child: Stack(
//                        children: [
//                          Container(
//                            height: 65,
//                            width: 65,
//                            child: isPhotoNull && !isChange
//                                ? Consumer<UsersProvider>(
//                              builder: (context, dataUser, _) {
//                                return CircleAvatar(
//                                  backgroundColor: PaletteColor.grey40,
//                                  radius: SpacingDimens.spacing16,
//                                  child: Text(
//                                    dataUser.user.data.nama[0]
//                                        .capitalize(),
//                                    style: TypographyStyle.title.merge(
//                                      TextStyle(
//                                        fontSize: SpacingDimens.spacing32,
//                                      ),
//                                    ),
//                                  ),
//                                );
//                              },
//                            )
//                                : isChange
//                                ? ClipRRect(
//                              borderRadius:
//                              BorderRadius.circular(100),
//                              child: Image.file(
//                                _image,
//                                width: 100,
//                                height: 100,
//                                fit: BoxFit.cover,
//                              ),
//                            )
//                                : CachedNetworkImage(
//                              imageUrl: urlPhoto,
//                              placeholder: (context, url) =>
//                                  indicatorLoad(),
//                              imageBuilder: (context, images) {
//                                return CircleAvatar(
//                                  backgroundImage: images,
//                                  backgroundColor: Colors.transparent,
//                                );
//                              },
//                            ),
//                          ),
//                          Positioned.fill(
//                            child: Icon(
//                              Icons.camera,
//                              color: PaletteColor.primarybg,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
                    _editField(
                      title: "No.Tiket",
                      hint: "Masukkan No Tiket",
                      type: TextInputType.number,
                      controller: _nameController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Tanggal",
                      hint: "Masukkan No. Telepon",
                      type: TextInputType.number,
                      controller: _noTeleponController,
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
                        hint: Text("Jenis Kelamin"),
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
                      controller: _alamatController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Tindak Lanjut",
                      hint: "Masukkan Tindak Lanjut",
                      type: TextInputType.text,
                      controller: _alamatController,
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
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: SpacingDimens.spacing48,
                        child: Text(
                          'Sunting',
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
//        nama: _nameController.text,
//        alamat: _alamatController.text,
//        idUser: Provider.of<UsersProvider>(context, listen: false)
//            .user
//            .data
//            .id
//            .toString(),
//        jenisKelamin: _valGender,
//        noTelp: _noTeleponController.text,
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
//        nama: _nameController.text,
//        alamat: _alamatController.text,
//        idUser: Provider.of<UsersProvider>(context, listen: false)
//            .user
//            .data
//            .id
//            .toString(),
//        jenisKelamin: _valGender,
//        noTelp: _noTeleponController.text,
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isChange = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isChange = true;
      } else {
        print('No image selected.');
      }
    });
  }
}
