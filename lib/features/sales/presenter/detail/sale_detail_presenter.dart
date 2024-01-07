import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sale_details_dto.dart';
import 'package:driver_hub_partner/features/sales/presenter/sales_state.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/receipt/receipt_sale_entity.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SaleDetailsPresenter extends Cubit<DHState> {
  SaleDetailsPresenter() : super(DHInitialState());

  final SalesInteractor _salesInteractor =
      DHInjector.instance.get<SalesInteractor>();
  late SaleDetailsDto saleDetailsDto;

  void load(String id) async {
    try {
      emit(DHLoadingState());
      saleDetailsDto = await _salesInteractor.getDetails(id);
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void addPhotoToCheckList(XFile photo) {
    saleDetailsDto.data.photoList.add(
      CheckListPhoto(
        id: "",
        file: photo,
      ),
    );
    emit(SaleNewPhotoCaptured(file: photo));
  }

  void removePhoto(CheckListPhoto photo) async {
    try {
      emit(SalePhotoRemovindLoading());
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      // _salesInteractor.removeSalePhoto(photo);
      saleDetailsDto.data.photoList.removeWhere(
        (element) => element.id == photo.id,
      );
      emit(SalePhotoRemoved(checkListPhoto: photo));
    } catch (e) {
      emit(
        DHErrorState(
          error:
              "Infelizmente não foi possível remover a foto, no momento, tente novamente mais tarde",
        ),
      );
    }
  }

  ReceiptSaleEntity getSaleReceiptEntity() {
    List<String> services = [];
    for (var service in saleDetailsDto.data.services) {
      MoneyValue price = service.chargedPrice;
      services.add("${service.serviceName} (${price.priceInReal})");
    }

    ReceiptSaleEntity entity = ReceiptSaleEntity(
        customerName: saleDetailsDto.data.client.name.name,
        partnerName: saleDetailsDto.data.partner.name,
        partnerLogo: saleDetailsDto.data.partner.logo,
        services: services,
        total: saleDetailsDto.data.totalAmountPaid,
        discount: saleDetailsDto.data.discountValue,
        subTotal: saleDetailsDto.data.subTotalPaid,
        vehicle: saleDetailsDto.data.client.vehicle,
        saleDate: saleDetailsDto.data.saleDate);
    return entity;
  }
}
