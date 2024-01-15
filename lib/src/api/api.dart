class Api {
  // static const BASE_URL = "https://conforthourse.000webhostapp.com/autocare";

  static const BASE_URL = "http://192.168.0.152/autocare";
  static const REGISTER = "/acteurs/register.php";
  static const LOGIN = '/acteurs/login.php';

  //Ajout et  Récupération de bien
  static const ADD_BIEN = '/biens/add.php';
  static const ALL_BIENS_BY_ACTEUR = '/biens/all_acteur.php';
  static const ALL_BIENS = '/biens/all.php';
  static const BIEN_BY_NUM = '/biens/get_by_num.php';
}
