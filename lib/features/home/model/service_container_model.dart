class ServiceContainerModel {
 final String title;
 final bool expanded;

 const ServiceContainerModel({
  required this.title,
  this.expanded = false,
 });

 ServiceContainerModel copyWith({
  String? title,
  bool? expanded,
 }) {
  return ServiceContainerModel(
   title: title ?? this.title,
   expanded: expanded ?? this.expanded,
  );
 }
}