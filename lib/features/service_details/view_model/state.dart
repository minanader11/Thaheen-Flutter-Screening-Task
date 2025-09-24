import 'package:base_project/features/service_details/model/service_container_model.dart';

class ServiceDetailsState {
  final List<ServiceContainerModel> servicesItems;

  const ServiceDetailsState({
    this.servicesItems = const [
      ServiceContainerModel(title: "Conditions", expanded: false),
      ServiceContainerModel(title: "Docs", expanded: false),
    ],
  });

  ServiceDetailsState copyWith({
    List<ServiceContainerModel>? servicesItems,
  }) {
    return ServiceDetailsState(
      servicesItems: servicesItems ?? this.servicesItems,
    );
  }
}