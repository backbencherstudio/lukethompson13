enum StopLogStep {
  arrivalTime('arrival_time'),
  dockInTime('dock_in_time'),
  completedTime('completed_time'),
  departureTime('departure_time');

  final String value;
  const StopLogStep(this.value);

  @override
  String toString() => value;
}
