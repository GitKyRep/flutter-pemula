class Person {
  String firstName;
  String lastName;
  String phoneNumber;
  String companyName;
  String email;
  String about;
  String imageAsset;

  Person(this.firstName, this.lastName, this.phoneNumber, this.companyName,
      this.email, this.about, this.imageAsset);
}

var dataPersonList = [
  Person(
    "andrea",
    "pirlo",
    "0896-9951-8116",
    "PT. Milanisti",
    "pirlo@mail.com",
    "Gelandang tengah",
    'images/pirlo.jpg',
  ),
  Person(
    "Frank",
    "Lampard",
    "0896-1122-3344",
    "PT. The Blues",
    "lampard@mail.com",
    "Gelandang Serang",
    'images/lampard.jpg',
  ),
];
