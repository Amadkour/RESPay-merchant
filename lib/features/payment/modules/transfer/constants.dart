List<String> transferToOptions = <String>["All Contact", "Favorite", "National", "Local"];

String urlFromEnum(String? baseUrlModules){
  if(baseUrlModules=="authentication"){
    return "/authentication.eightyythree.com/api/$baseUrlModules";
  }
  if(baseUrlModules=="ecommerce"){
    return "/res-ecommerce.eightyythree.com/api/$baseUrlModules";
  }
  if(baseUrlModules=="finance"){
    return "/fgipay.eightyythree.com/api/$baseUrlModules";
  }
  if(baseUrlModules=="wallet"){
    return "/wallet.eightyythree.com/api/$baseUrlModules";
  }
  return "/authentication.eightyythree.com/api/$baseUrlModules";
}
