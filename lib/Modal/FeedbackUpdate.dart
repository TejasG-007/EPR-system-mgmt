class FeedbackUpdate {
  late Map Feedback;

  FeedbackUpdate({required this.Feedback});

  FeedbackUpdate.fromMap(Map<String, dynamic> map) {
    this.Feedback = map["Feedback"];
  }

  Map<String, dynamic> toMap() {
    return {
      "Feedback": this.Feedback,
    };
  }
}
