public without sharing class sfcraft_LwcApiDependencies {
    private static sfcraft_LwcApiDependencies instance;

    public static sfcraft_LwcApiDependencies getInstance() {
        if (null == instance) {
            instance = new sfcraft_LwcApiDependencies();
        }
        return instance;
    }

    private sfcraft_LwcApiSettings__c settings;

    private sfcraft_ILwcApiErrorHandler errorHandler;

    private sfcraft_LwcApiDependencies() {
        List<sfcraft_LwcApiSettings__c> settingExistenceCheck = [
            SELECT Id
            FROM sfcraft_LwcApiSettings__c
            WHERE SetupOwnerId = :UserInfo.getOrganizationId()
        ];
        if (settingExistenceCheck.isEmpty()) {
            insert new sfcraft_LwcApiSettings__c();
        }
        this.settings = sfcraft_LwcApiSettings__c.getInstance(
            UserInfo.getUserId()
        );
    }

    public sfcraft_ILwcApiErrorHandler getErrorHandler() {
        if (null == this.errorHandler) {
            String errorHandlerName = this.settings.ErrorHandlerImplementation__c;
            this.errorHandler = (sfcraft_ILwcApiErrorHandler) Type.forName(
                    errorHandlerName
                )
                .newInstance();
        }
        return this.errorHandler;
    }
}
