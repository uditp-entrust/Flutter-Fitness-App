class CyclingSession {
  String id,
      userId,
      location,
      area,
      city,
      state,
      country,
      day,
      phoneNumber,
      contactPersonName,
      participateType,
      numberOfParticipants,
      type;

  List selectedDays;
  List<DateTime> sessionDateRange;
  List latlong;

  int sessionMinute, sessionHour;

  double latitude, longitude;

  CyclingSession(
      {this.id,
      this.userId,
      this.location,
      this.area,
      this.city,
      this.state,
      this.country,
      this.day,
      this.phoneNumber,
      this.contactPersonName,
      this.participateType,
      this.numberOfParticipants,
      this.latitude,
      this.longitude,
      this.sessionHour,
      this.sessionMinute,
      this.selectedDays,
      this.sessionDateRange,
      this.latlong,
      this.type});
}
