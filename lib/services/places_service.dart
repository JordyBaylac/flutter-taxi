import 'package:zitotaxi/models/place.dart';

Future<List<Place>> placesGetIconic() async {
  return Future.delayed(Duration(seconds: 1), () {
    return [
      Place(
        "Capitolio",
        "Havana",
        "El Capitolio, or the National Capitol Building (Capitolio Nacional de La Habana) is a public edifice and one of the most visited sites in Havana, capital of Cuba.",
        "assets/cuba/capitolio.jpg",
      ),
      Place(
        "Viñales Valley",
        "Pinar del Río Province.",
        "Viñales Valley (Spanish: Valle de Viñales) is a karstic depression in Cuba. The valley has an area of 132 km2 (51 sq mi) and is located in the Sierra de los Órganos mountains (part of Guaniguanico range), just north of Viñales in the Pinar del Río Province.",
        "assets/cuba/valle.jpg",
      ),
    ];
  });
}
