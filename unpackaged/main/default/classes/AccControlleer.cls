public with sharing class AccControlleer {
    public AccControlleer() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRecords( String searchKey) {
       
        String query = 'SELECT Id, Name, FROM Contact';
        system.debug('query---'+query);
        if ( searchKey != null && searchKey != '' ) {
            String key = '%' + searchKey + '%';
            query += ' WHERE Name LIKE :key';
        
		
		}
        return Database.query( query );
		
		}
    }