enum AppointmentStatus {
  pending, // Client or enterprise has requested the appointment, awaiting confirmation.
  confirmed, // Appointment is confirmed and scheduled.
  cancelledByClient, // Client has cancelled the appointment.
  cancelledByProvider, // Provider (enterprise or assigned employee) has cancelled the appointment.
  //rescheduled, // Appointment has been rescheduled (consider adding a new `rescheduleDetails` property to `Appointment` for details).
  completed, // Appointment has been completed.
  // noShow, // Client or provider did not show up for the appointment.
}
