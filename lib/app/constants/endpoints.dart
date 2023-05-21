abstract class Endpoints {
  static const String login = '/login';
  static const String register = '/register';
  static const String createMeeting = '/createMeeting';
  static const String getAllMeetings = '/createMeeting/all';
  static String deleteMeeting({required String id}) => '/createMeeting/$id';
  static const String getPendingMeetings = '/createMeeting/all';
  static String voteMeetingDate({required String id, required String currentUser}) =>
      '/createMeeting/pending/$id/$currentUser';
  static String addParticipant({required String id}) => '/createMeeting/$id';
  static String iCannotAttend({required String id}) => '/createMeeting/removeParticipant/$id';
}
