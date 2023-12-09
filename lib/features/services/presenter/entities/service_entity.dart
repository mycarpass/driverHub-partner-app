import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';

class ServiceEntity with CustomDropdownListFilter {
  int? id;
  String name;
  String? description;
  String? serviceTimeHours;
  String? daysPosSales;
  ServiceCategory category;
  ServiceType type;
  bool isLiveOnApp;
  bool? isSelected = false;
  double? basePrice;

  ServiceEntity(
    this.id,
    this.name,
    this.description,
    this.serviceTimeHours,
    this.daysPosSales,
    this.category,
    this.type,
    this.isLiveOnApp,
  );

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
