import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify.dart';

class AnalyticsService {
  static Future<void> recordEvent({AnalyticsEvent event}) {
    return Amplify.Analytics.recordEvent(event: event);
  }
}
