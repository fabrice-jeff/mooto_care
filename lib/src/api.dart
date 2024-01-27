class Api {
  // static const BASE_URL = "https://conforthourse.000webhostapp.com/autocare";

  static const BASE_URL = "http://192.168.137.1/autocare";
  static const REGISTER = "/acteurs/register.php";
  static const LOGIN = '/acteurs/login.php';

  //  Biens
  static const ADD_BIEN = '/biens/add.php';
  static const ALL_BIENS_BY_ACTEUR = '/biens/all_acteur.php';
  static const ALL_BIENS = '/biens/all.php';
  static const BIEN_BY_NUM = '/biens/get_by_num.php';

  // Plaintes
  static const ADD_PLAINTE = '/plaintes/add_plainte.php';
  static const ADD_DEMANDE_ATTESTATION =
      '/plaintes/add_demande_attestation.php';
  static const ALL_PLAINTES = '/plaintes/all_plaintes.php';
}
