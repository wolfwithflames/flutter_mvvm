import 'dart:convert';
import 'dart:developer';

/// A Logger For Flutter Apps
/// Usage:
/// 1) AppLog.i("Info Message");
/// 2) AppLog.i("Home Page", tag: "User Logging");
class AppLog {
  static JsonEncoder encoder = const JsonEncoder.withIndent("     ");

  static const String _defaultTagPrefix = "Network Utils";

  ///use Log.v. Print all Logs
  static const int verbos = 2;

  ///use Log.d. Print Debug Logs
  static const int debug = 3;

  ///use Log.i. Print Info Logs
  static const int info = 4;

  ///use Log.w. Print warning logs
  static const int warn = 5;

  ///use Log.e. Print error logs
  static const int error = 6;

  ///use Log.wtf. Print Failure Logs(What a Terrible Failure= WTF)
  static const int wtf = 7;

  ///SET APP LOG LEVEL, Default ALL
  static int _currentLogLevel = verbos;

  static setLogLevel(int priority) {
    int newPriority = priority;
    if (newPriority <= verbos) {
      newPriority = verbos;
    } else if (newPriority >= wtf) {
      newPriority = wtf;
    }
    _currentLogLevel = newPriority;
  }

  static int getLogLevel() {
    AppLog.i("Current Log Level is ${_getPriorityText(_currentLogLevel)}");
    return _currentLogLevel;
  }

  static _log(int priority, String tag, String message) {
    if (_currentLogLevel <= priority) {
      log("${_getPriorityText(priority)}$tag: $message");
    }
  }

  static String _getPriorityText(int priority) {
    switch (priority) {
      case info:
        return "INFOⓘ | ";
      case debug:
        return "DEBUG | ";
      case error:
        return "ERROR⚠️ |️ ";
      case warn:
        return "WARN⚠️ | ";
      case wtf:
        return "WTF¯\\_(ツ)_/¯ | ";
      case verbos:
      default:
        return "";
    }
  }

  ///Print general logs
  static v(String message, {String tag = _defaultTagPrefix}) {
    _log(verbos, tag, message);
  }

  ///Print info logs
  static i(dynamic message, {String tag = _defaultTagPrefix}) {
    _log(info, tag, message.toString());
  }

  ///Print debug logs
  static d(dynamic message, {String tag = _defaultTagPrefix}) {
    _log(debug, tag, message.toString());
  }

  ///Print warning logs
  static w(String message, {String tag = _defaultTagPrefix}) {
    _log(warn, tag, message);
  }

  ///Print error logs
  static e(dynamic message, {String tag = _defaultTagPrefix}) {
    _log(error, tag, message.toString());
  }

  ///Print failure logs
  static wthef(String message, {String tag = _defaultTagPrefix}) {
    _log(wtf, tag, message);
  }

  static prettyPrint(Map message, {String tag = _defaultTagPrefix}) {
    _log(wtf, tag, encoder.convert(message));
  }
}
