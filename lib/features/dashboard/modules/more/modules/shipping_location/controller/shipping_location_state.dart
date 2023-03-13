part of 'shipping_location_cubit.dart';

abstract class ShippingLocationState {}

class ShippingLocationInitial extends ShippingLocationState {}

class ShippingLocationLoadLocation extends ShippingLocationState {}

class ShippingLocationLoadedLocation extends ShippingLocationState {}

class ShippingLocationAddLocation extends ShippingLocationState {}

class ShippingLocationChangeAddress extends ShippingLocationState {}

class ShippingLocationDeleteAddress extends ShippingLocationState {}
class ShippingLocationUpdateAddress extends ShippingLocationState {}
class ShippingLocationAddressUpdated extends ShippingLocationState {}

class ShippingLocationAddAddressLoad extends ShippingLocationState {}

class ShippingLocationAddAddressLoaded extends ShippingLocationState {}

class ShippingLocationGetAddressesLoading extends ShippingLocationState {}

class ShippingLocationGetAddressesLoaded extends ShippingLocationState {}

class ShippingLocationFailure extends ShippingLocationState {}

class ShippingLocationUpdateScreen extends ShippingLocationState {}

class ShippingLocationChangeCheckBoxValue extends ShippingLocationState {}

class ShippingLocationChangeCity extends ShippingLocationState {}

class ShippingLocationCurrentPositionLoad extends ShippingLocationState {}

class ShippingLocationCurrentPositionLoaded extends ShippingLocationState {}

class ShippingLocationCitiesLoading extends ShippingLocationState {}

class ShippingLocationCitiesLoaded extends ShippingLocationState {}
