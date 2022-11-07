class FeedbackUpdate {
  late String feedback_written;
  late String feedback_oral;
  late String feedback_date;

  FeedbackUpdate({required this.feedback_date,required this.feedback_written,required this.feedback_oral});

  FeedbackUpdate.fromMap(Map<String, dynamic> map) {
    this.feedback_oral = map["feedback_oral"];
    this.feedback_written = map["feedback_written"];
    this.feedback_date= map["feedback_date"];
  }

  Map<String, dynamic> toMap() {
    return {
      "feedback_date":this.feedback_date,
      "feedback_oral":this.feedback_oral,
      "feedback_written":this.feedback_written,
    };
  }
}
