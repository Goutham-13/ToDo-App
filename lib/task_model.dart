class Task {
  String title;
  bool isDone;
  bool isStarred;
  bool isDeleted; // ✅ Add this

  Task({
    required this.title,
    this.isDone = false,
    this.isStarred = false,
    this.isDeleted = false, // ✅ Set default
  });
}
