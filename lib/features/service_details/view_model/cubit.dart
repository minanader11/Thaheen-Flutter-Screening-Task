import 'package:bloc/bloc.dart';
import 'package:base_project/features/service_details/model/service_container_model.dart';

import 'package:base_project/features/service_details/view_model/state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(const ServiceDetailsState());

  changeExpansion(index) {
    final updatedItems = List<ServiceContainerModel>.from(state.servicesItems);

    updatedItems[index] = updatedItems[index].copyWith(
      expanded: !updatedItems[index].expanded,
    );

    emit(state.copyWith(servicesItems: updatedItems));
  }

//=========================== Login Functionality ===========================
//add the logic for login here
//=========================== Login Api Calls ===============================
//add the api calls for login here
}
