class Api {
  // static const BASE_URL = "https://conforthourse.000webhostapp.com/autocare";

  // static const BASE_URL = "http://10.10.38.13/autocare";
  static const BASE_URL = "http://10.0.2.2:8000/api";
  // static const REGISTER = "/acteurs/register.php";
  // static const LOGIN = '/acteurs/login.php';

  // //  Biens
  // static const ADD_BIEN = '/biens/add.php';
  // static const ALL_BIENS_BY_ACTEUR = '/biens/all_acteur.php';
  // static const ALL_BIENS = '/biens/all.php';
  // static const BIEN_BY_NUM = '/biens/get_by_num.php';

  // // Plaintes
  // static const ADD_PLAINTE = '/plaintes/add_plainte.php';
  // static const ADD_DEMANDE_ATTESTATION =
  //     '/plaintes/add_demande_attestation.php';
  // static const ALL_PLAINTES = '/plaintes/all_plaintes.php';
  static const register = "/acteurs/register";
  static const login = '/acteurs/login';
  static const verificationEmail = '/acteurs/verification_email';

  //  Biens
  static const ADD_BIEN = '/biens/add';
  static const ALL_BIENS_BY_ACTEUR = '/biens/all_acteur';
  static const ALL_BIENS = '/biens/all.php';
  static const BIEN_BY_NUM = '/biens/get_by_num';
  static const ASSURE_BEIN = '/biens/assure_bien';

  // Plaintes
  static const ADD_PLAINTE = '/plaintes/add_plainte';
  static const ADD_DEMANDE_ATTESTATION = '/plaintes/add_demande_attestation';
  static const ALL_PLAINTES = '/plaintes/all_plaintes';

  // Types
  static const TYPE_COUVERTURE = '/type_type/convertures';
}
