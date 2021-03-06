// https://hackernoon.com/creating-a-custom-listview-using-the-firebase-realtime-database-in-flutter-j02xw3w6z

class Articolo {
  final String articolo;
  final String titolo;
  final String testo;
  final String sanzione;
  final String comune;
  final String categoria;
  Articolo(this.articolo, this.titolo, this.testo, this.sanzione, this.comune, this.categoria);

  factory Articolo.fromJson(List<dynamic> json){
    return Articolo(
      json[0].toString(),
      json[1].toString(),
      json[2].toString(),
      json[3].toString(),
      json[4].toString(),
      json[5].toString(),
    );
  }
}
