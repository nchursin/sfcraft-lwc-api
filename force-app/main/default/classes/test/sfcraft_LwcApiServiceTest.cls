@IsTest
private class sfcraft_LwcApiServiceTest {
    @IsTest
    private static void getRecord() {
        Account testAcc = new Account(Name = 'TestAccount');
        insert testAcc;

        sfcraft_LwcApiService service = new sfcraft_LwcApiService();
        Account actual = (Account) service.getRecord(
            testAcc.Id,
            new List<String>{ 'Id', 'Name' }
        );

        System.assertEquals(testAcc, actual);
    }

    @IsTest
    private static void throwsExceptionIfRecordNotFound() {
        Id recordId = '001000010000100AAA';
        sfcraft_LwcApiService service = new sfcraft_LwcApiService();
        try {
            service.getRecord(recordId, new List<String>{ 'Id' });
        } catch (sfcraft_LwcApiException ex) {
            System.assertEquals(
                'No record found for id: ' + recordId,
                ex.getMessage(),
                'Exception message is different from expected'
            );
        }
    }
}
