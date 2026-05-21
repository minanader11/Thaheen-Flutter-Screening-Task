class EndPoints {
  // Example End Points
  static String login = "/auth/login";
  static const String teams        = 'teams';
  static const String tasks        = 'tasks';
  static String teamScore(int id)  => 'teams/$id/score';
  static String deleteTask(int id) => 'tasks/$id';
  static const String imageBaseURl        = 'http://localhost:5171';

}
