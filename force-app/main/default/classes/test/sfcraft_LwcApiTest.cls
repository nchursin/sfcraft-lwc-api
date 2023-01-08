@isTest
private class sfcraft_LwcApiTest {
    private static final String exMessage = 'test exception';

    @IsTest
    private static void testGetRecord() {
        Account testAcc = new Account(Name = 'TestAccount');
        insert testAcc;

        Account actual = (Account) sfcraft_LwcApi.getRecord(
            testAcc.Id,
            new List<String>{ 'Id', 'Name' }
        );

        System.assertEquals(testAcc, actual);
    }

    @IsTest
    private static void testExceptionHandler() {
        sfcraft_LwcApi.service = new ExceptionService();

        Account testAcc = new Account(Name = 'TestAccount');
        insert testAcc;

        try {
            Account actual = (Account) sfcraft_LwcApi.getRecord(
                testAcc.Id,
                new List<String>{ 'Id', 'Name' }
            );
            System.assert(false, 'AuraHandledException expected');
        } catch (AuraHandledException ex) {
            System.assertEquals(exMessage, ex.getMessage());
        }
    }

    private class ExceptionService implements sfcraft_ILwcApiService {
        public SObject getRecord(Id recordId, List<String> fields) {
            throw new sfcraft_LwcApiException(exMessage);
        }
    }
}
