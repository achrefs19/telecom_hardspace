String computerImageTaken(String name){
  if(name.contains("dell")) {
    return '/assets/images/computers/dell_g15.jpg';
  } else {
    return "assets/images/computers/dell_g15.jpg";
  }
}

String userImageTaken(String role){
  if(role.contains("it")) {
    return 'assets/images/users/it.png';
  } else {
    return "assets/images/users/hr.png";
  }
}