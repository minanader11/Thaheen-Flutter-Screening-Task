class EndPoints {
  // Example End Points
  static String login = "/auth/login";
  static const String teams        = 'teams';
  static const String tasks        = 'tasks';
  static String teamScore(int id)  => 'teams/$id/score';
  static String deleteTask(int id) => 'tasks/$id';
  static const String imageBaseURl        = 'https://ljfscoring.runasp.net';


  // ── New: Car progress ──────────────────────────────────────
  static String carProgress(int teamId) => 'teams/$teamId/car-progress';

  // ── New: Bank ───────────────────────────────────────────────
  static const String bankCertificates = 'bank/certificates';
  static String bankCertificateById(int id) => 'bank/certificates/$id';
  static String teamPurchases(int teamId) => 'teams/$teamId/bank/purchases';
  static String redeemPurchase(int teamId, int purchaseId) =>
      'teams/$teamId/bank/purchases/$purchaseId/redeem';
  static String teamBankBalance(int teamId) => 'teams/$teamId/bank/balance';

  // ── New: University ─────────────────────────────────────────
  static const String universityAttendees = 'university/attendees';

  // ── New: Event config ───────────────────────────────────────
  static const String eventConfig = 'event/config';
}
