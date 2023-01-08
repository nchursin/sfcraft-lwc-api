public with sharing class sfcraft_LwcApi {
    @TestVisible
    private static sfcraft_ILwcApiService service {
        get {
            if (null == service) {
                service = new sfcraft_LwcApiService();
            }
            return service;
        }
        set;
    }

    private static sfcraft_ILwcApiErrorHandler errorHandler {
        get {
            if (null == errorHandler) {
                errorHandler = new sfcraft_LwcApiDefaultErrorHandler();
            }
            return errorHandler;
        }
        set;
    }

    @AuraEnabled
    public static SObject getRecord(Id recordId, List<String> fields) {
        try {
            return service.getRecord(recordId, fields);
        } catch (Exception e) {
            errorHandler.handleException(e);
            Exception newEx = new AuraHandledException(e.getMessage());
            newEx.setMessage(e.getMessage());
            throw newEx;
        }
    }
}
