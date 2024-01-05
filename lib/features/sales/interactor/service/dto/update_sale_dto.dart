import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/service_date.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

class UpdateSaleDto {
  final int id;
  final List<ServiceDto> services;
  final String discontValue;
  final PaymentType paymentType;
  final CustomerDto customerDto;
  final ServiceDate serviceDate;

  UpdateSaleDto(
      {required this.services,
      required this.discontValue,
      required this.paymentType,
      required this.customerDto,
      required this.serviceDate,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      "lead_partner_id": customerDto.customerId,
      "services": _servicesToJson(),
      "discount_value": discontValue,
      "payment_type_id": paymentType.toInt(),
      "sale_date": serviceDate.rawDate
    };
  }

  List<Map<String, dynamic>> _servicesToJson() {
    return [
      ...services.map(
        (e) => {
          "price_id": e
              .finPrice(customerDto.vehicle?.bodyType ??
                  customerDto.manualBodyTypeSelected!)
              .priceId,
          "value": e
              .getPriceByCarBodyType(customerDto.vehicle?.bodyType ??
                  customerDto.manualBodyTypeSelected!)
              .getStringValueWithoutSimbols()
        },
      )
    ];
  }
}
