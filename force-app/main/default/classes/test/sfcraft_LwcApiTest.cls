@isTest
private class sfcraft_LwcApiTest {
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
}
