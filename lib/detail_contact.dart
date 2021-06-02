import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_book/list_contact.dart';
import 'package:phone_book/model/person.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailContact extends StatelessWidget {
  final Person person;
  final int index;

  DetailContact(this.person, this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailMobileContact(person, index);
        } else {
          return DetailMobileContact(person, index);
        }
      },
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        });
  }
}

class DetailMobileContact extends StatefulWidget {
  final Person person;
  final int index;

  DetailMobileContact(this.person, this.index);

  @override
  _DetailMobileContactState createState() => _DetailMobileContactState();
}

class _DetailMobileContactState extends State<DetailMobileContact> {
  var informationTextStyle =
      TextStyle(fontFamily: "Oxygen", color: Colors.blue);
  final listContact = ListContact();

  @override
  Widget build(BuildContext context) {
    var phoneNumber =
        widget.person.phoneNumber.replaceAll(new RegExp(r'[^0-9]'), '');

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              FavoriteButton(),
            ],
            expandedHeight: 220.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    centerTitle: false,
                    collapseMode: CollapseMode.pin,
                    title: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: top > 50 && top < 120 ? 1.0 : 0,
                      child: Text(
                          top > 50 && top < 120
                              ? "${widget.person.firstName} ${widget.person.lastName}"
                                  .toUpperCase()
                              : "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    ),
                    background: Hero(
                      tag: "avatar-${widget.index}",
                      child: imageContact(widget.person),
                    ));
              },
            ),
          ),
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${widget.person.firstName} ${widget.person.lastName}"
                              .toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Oxygen"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${widget.person.companyName}".toUpperCase(),
                          style: TextStyle(fontSize: 12, fontFamily: "Oxygen"),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.call, color: Colors.blue),
                              onPressed: () {
                                listContact.callNumber(
                                    context, widget.person.phoneNumber);
                              }),
                          SizedBox(height: 8.0),
                          Text(
                            "Telepon",
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.message_outlined,
                                  color: Colors.blue),
                              onPressed: () {
                                launch("sms:$phoneNumber?body=hello%20there");
                              }),
                          SizedBox(height: 8.0),
                          Text(
                            "SMS",
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.videocam_outlined,
                                  color: Colors.blue),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Video tidak tersedia"),
                                  duration: Duration(seconds: 1),
                                ));
                              }),
                          SizedBox(height: 8.0),
                          Text(
                            "Video",
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                launch(
                                    "mailto:${widget.person.email}?subject=TestEmail&body=How are you%20plugin");
                              }),
                          SizedBox(height: 8.0),
                          Text(
                            "Email",
                            style: informationTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              listContact.callNumber(context, phoneNumber);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: Icon(Icons.call),
                                      color: Colors.grey,
                                      onPressed: () {
                                        listContact.callNumber(
                                            context, widget.person.phoneNumber);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.person.phoneNumber,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Ponsel",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              launch(
                                  "mailto:${widget.person.email}?subject=TestEmail&body=How are you%20plugin");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: Icon(Icons.mail_outline),
                                      color: Colors.grey,
                                      onPressed: () {
                                        listContact.callNumber(
                                            context, widget.person.phoneNumber);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.person.email,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 34.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Tentang ${widget.person.firstName} ${widget.person.lastName}"
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Oxygen",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(Icons.person_outlined),
                                    color: Colors.grey,
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.person.about,
                                            style: TextStyle(fontSize: 16),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageContact(Person person) {
    if (person.imageAsset == "") {
      var name = (person.lastName == "")
          ? "${person.firstName[0]}".toUpperCase()
          : "${person.firstName[0]}${person.lastName[0]}".toUpperCase();
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(
          child: RoundedLetter(
            text: "$name",
            shapeColor: Color(0xFF1ECCE3),
            shapeType: ShapeType.circle,
            borderColor: Color(0xFF2AECEC),
            borderWidth: 1,
            shapeSize: 120,
            fontSize: 30,
            key: Key(person.firstName),
          ),
        ),
      );
    } else {
      return Image.asset(
        "${widget.person.imageAsset}",
        fit: BoxFit.cover,
      );
    }
  }
}
