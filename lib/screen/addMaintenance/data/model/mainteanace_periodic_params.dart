class MaintenancePeriodicParams {
  final String city;
  final String name;
  final String customerId;
  final String location;
  final String numElevators;
  final String model;
  final String numberStops;
  final String maximumLoad;
  final String installDate;
  final String statusElevator;
  final String availableCompany;

  MaintenancePeriodicParams({
    required this.city,
    required this.name,
    required this.customerId,
    required this.location,
    required this.numElevators,
    required this.model,
    required this.numberStops,
    required this.maximumLoad,
    required this.installDate,
    required this.statusElevator,
    required this.availableCompany,
  });

  Map<String, String> toJson() => {
        'name': name,
        'city': city,
        'customer_id': customerId,
        'location': location,
        'numelevaters': numElevators,
        'model': model,
        'NumberofStops': numberStops,
        'maximumload': maximumLoad,
        'installdate': installDate,
        'statuselevator': statusElevator,
        'availablecompany': availableCompany,
      };
}
