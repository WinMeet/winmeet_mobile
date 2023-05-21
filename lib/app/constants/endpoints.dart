abstract class Endpoints {
  static const String login = '/login';
  static const String register = '/register';
  static const String createMeeting = '/createMeeting';
  static const String getAllMeetings = '/createMeeting/all';
  static const String deleteMeeting = '/createMeeting/';
  static const String getPendingMeetings = '/createMeeting/all';
  static const String voteMeetingDate = '/createMeeting/pending';
  static const String addParticipant = '/createMeeting';
  static const String iCannotAttend = '/createMeeting/removeParticipant';
}
