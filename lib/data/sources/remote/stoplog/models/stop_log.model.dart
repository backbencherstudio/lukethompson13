enum StopLogStep {
  arrivalTime('arrival_time'),
  dockInTime('dock_in_time'),
  completedTime('completed_time'),
  departureTime('departure_time'),
  uploadDocuments('upload_documents');

  final String value;
  const StopLogStep(this.value);

  static StopLogStep? fromValue(String? value) =>
      values.where((e) => e.value == value).firstOrNull;

  @override
  String toString() => value;
}
