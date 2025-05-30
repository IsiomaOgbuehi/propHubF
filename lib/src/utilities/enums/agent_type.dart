enum AgentType {
  legalDraftsman('LEGAL_DRAFTS_MAN', 'Legal Draftsman'),
  architect('ARCHITECT', 'Architect'),
  surveyor('SURVEYOR', 'Surveyor'),
  propertyDevelopmentMgt('PROPERTY_DEVELOPMENT', 'Property Development & Mgt'),
  artisan('ARTISAN', 'Artisan'),
  advertisingAgent('ADVERTISING_AGENT', 'Advertising Agent'),
  businessAgent('BUSINESS_AGENT', 'Business Agent'),
  customer('CUSTOMER', 'Customer');

  const AgentType(this.jsonString, this.value);

  final String jsonString;
  final String value;
}

extension AgentTypeX on String {
  AgentType get agentType =>
      AgentType.values.firstWhere((e) => e.jsonString == this || e.value == this, orElse: () => AgentType.legalDraftsman);
}
