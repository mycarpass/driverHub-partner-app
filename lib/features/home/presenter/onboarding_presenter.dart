import 'package:dh_dependency_injection/dh_dependency_injection.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/onboarding_interactor.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/logo_dto.dart';
import 'package:driver_hub_partner/features/home/presenter/entities/bank_entity.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingPresenter extends Cubit<DHState> {
  OnboardingPresenter() : super(DHInitialState());

  final OnboardingInteractor _onboardingInteractor =
      DHInjector.instance.get<OnboardingInteractor>();

  late PartnerDataDto partnerDataDto;

  BankEntity? bankEntitySelected;
  BankAccountDto bankAccountDto = BankAccountDto(id: "");

  LogoAccountDto logoAccountDto = LogoAccountDto();

  bool isAllCompletedOnboarding(PartnerDataDto partnerData) {
    partnerDataDto = partnerData;
    return isLogoOnboardingCompleted() &&
        isBankAccountOnboardingCompleted() &&
        isServiceOnboardingCompleted();
  }

  bool isLogoOnboardingCompleted() {
    return partnerDataDto.thumb != '';
  }

  bool isBankAccountOnboardingCompleted() {
    return partnerDataDto.isBankAccountCreated;
  }

  bool isServiceOnboardingCompleted() {
    return partnerDataDto.isAnyServiceRegistered;
  }

  void selectBank(BankEntity bank) {
    bankEntitySelected = bank;
    bankAccountDto.bank = bank.name;
    bankAccountDto.bankCode = bank.code;
    emit(BankSelected(bankEntity: bank));
  }

  void changeTypePerson(String typePerson) {
    bankAccountDto.typePerson = typePerson;
    emit(ChangedTypePersonState(typePerson: typePerson));
  }

  void inputLogo(XFile? image) {
    logoAccountDto.pathLogo = image?.path;
    logoAccountDto.imageLogoFile = image;
    emit(LogoImageInputed(path: image?.path ?? ""));
  }

  void inputBackground(XFile? image) {
    logoAccountDto.pathBackground = image?.path;
    logoAccountDto.imageBackgroundFile = image;
    emit(BackgroundImageInputed(path: image?.path ?? ""));
  }

  Future<void> sendImageLogo() async {
    try {
      emit(DHLoadingState());
      await _onboardingInteractor.sendLogo(logoAccountDto);
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState(error: e.toString()));
    }
  }

  Future<void> saveBankAccount() async {
    try {
      emit(DHLoadingState());
      await _onboardingInteractor.saveBankAccount(bankAccountDto);
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState(error: e.toString()));
    }
  }

  List<BankEntity> banksList = const [
    BankEntity('260', 'Nubank', '####'),
    BankEntity('001', 'Banco do Brasil', '####-#'),
    BankEntity('033', 'Santander', '####'),
    BankEntity('104', 'Caixa Econômica', '####'),
    BankEntity('237', 'Bradesco', '####-#'),
    BankEntity('341', 'Itaú', '####'),
    BankEntity('041', 'Banrisul', '####'),
    BankEntity('748', 'Sicredi', '####'),
    BankEntity('756', 'Sicoob', '####'),
    BankEntity('077', 'Inter', '####'),
    BankEntity('070', 'BRB', '####'),
    BankEntity('085', 'Via Credi/Civia Cooperativa', '####'),
    BankEntity('655', 'Neon/Votorantim', '####'),
    BankEntity('290', 'Pagseguro', '####'),
    BankEntity('212', 'Banco Original', '####'),
    BankEntity('422', 'Safra', '####'),
    BankEntity('746', 'Modal', '####'),
    BankEntity('237', 'Next', '####-#'),
    BankEntity('021', 'Banestes', '####'),
    BankEntity('136', 'Unicred', '####'),
    BankEntity('274', 'Money Plus', '####'),
    BankEntity('389', 'Mercantil do Brasil', '####'),
    BankEntity('376', 'JP Morgan', '####'),
    BankEntity('364', 'Gerencianet Pagamentos do Brasil', '####'),
    BankEntity('336', 'Banco C6', '####'),
    BankEntity('218', 'BS2', '####'),
    BankEntity('082', 'Banco Topazio', '####'),
    BankEntity('099', 'Uniprime', '####'),
    BankEntity('197', 'Stone', '####'),
    BankEntity('707', 'Banco Daycoval', '####'),
    BankEntity('633', 'Rendimento', '####-#'),
    BankEntity('004', 'Banco do Nordeste', '###'),
    BankEntity('745', 'Citibank', '####'),
    BankEntity('301', 'PJBank', '####'),
    BankEntity(
        '97', 'Cooperativa Central de Credito Noroeste Brasileiro', '####'),
    BankEntity('084', 'Uniprime Norte do Paraná', '####'),
    BankEntity('384', 'Global SCM', '####'),
    BankEntity('403', 'Cora', '####'),
    BankEntity('323', 'Mercado Pago', '####'),
    BankEntity('003', 'Banco da Amazonia', '####'),
    BankEntity('752', 'BNP Paribas Brasil', '###'),
    BankEntity('383', 'Juno', '####'),
    BankEntity('133', 'Cresol', '####'),
    BankEntity('173', 'BRL Trust DTVM', '###'),
    BankEntity('047', 'Banco Banese', '###'),
    BankEntity('208', 'Banco BTG Pactual', '####'),
    BankEntity('613', 'Banco Omni', '####'),
    BankEntity('332', 'Acesso Soluções de Pagamento', '####'),
    BankEntity('273', 'CCR de São Miguel do Oeste', '####'),
    BankEntity('093', 'Polocred', '####'),
    BankEntity('355', 'Ótimo', '####'),
    BankEntity('121', 'Agibank', '####'),
    BankEntity('037', 'Banpará', '####'),
    BankEntity('380', 'Picpay', '####'),
    BankEntity('125', 'Banco Genial', '####'),
    BankEntity('412-x', 'Banco Capital S.A', '####'),
    BankEntity('741', 'Banco Ribeirão Preto', '#####'),
    BankEntity('461', 'ASAAS IP', '####'),
    BankEntity('623', 'Banco Pan', '####'),
    BankEntity('735', 'Neon', '####'),
    BankEntity('310', 'VORTX DTVM LTDA', '####-#'),
    BankEntity('318', 'Banco BMG', '####'),
    BankEntity('450', 'Fitbank', '####'),
    BankEntity('174', 'Pefisa', '####'),
    BankEntity('451', 'J17 - SCD S/A', '####'),
    BankEntity('089', 'Credisan', '####'),
    BankEntity('529', 'Pinbank', '###'),
    BankEntity('102', 'XP Investimentos', '####'),
    BankEntity('069', 'Crefisa', '####'),
    BankEntity('363', 'Singulare', '####'),
    BankEntity('404', 'SUMUP SCD S.A.', '####'),
    BankEntity('246', 'Banco ABC Brasil', '####-#'),
    BankEntity('630', 'Banco Letsbank S.A', '####'),
    BankEntity('523', 'HR Digital Sociedade de Crédito Direto S.A', '####'),
    BankEntity('348', 'BANCO XP S.A.', '####'),
    BankEntity('536', 'Neon Pagamentos S.A. IP', '####'),
    BankEntity('542', 'CLOUD WALK MEIOS DE PAGAMENTOS E SERVICOS LTDA', '####')
  ];
}
