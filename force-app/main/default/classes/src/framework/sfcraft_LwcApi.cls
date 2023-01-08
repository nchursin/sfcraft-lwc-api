public with sharing class sfcraft_LwcApi {
    private static sfcraft_LwcApiService service {
        get {
            if (null == service) {
                service = new sfcraft_LwcApiService();
            }
            return service;
        }
        set;
    }

    @AuraEnabled
    public static SObject getRecord(Id recordId, List<String> fields) {
        try {
            return service.getRecord(recordId, fields);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
