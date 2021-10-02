public inherited sharing class sfcraft_LwcApiService {
    public SObject getRecord(Id recordId, List<String> fields) {
        SObjectType sobjType = recordId.getSobjectType();
        String fieldsJoined = String.join(fields, ', ');
        String query =
            'SELECT ' +
            fieldsJoined +
            ' FROM ' +
            sobjType.getDescribe().getName() +
            ' WHERE Id = :recordId' +
            ' LIMIT 1';
        List<SObject> listOfSobjects = Database.query(query);
        if (listOfSobjects.isEmpty()) {
            throw new sfcraft_LwcApiException(
                'No record found for id: ' + recordId
            );
        }
        return listOfSobjects.get(0);
    }
}
