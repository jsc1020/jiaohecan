@isTest
public class TestRestrictContactByName {

    @isTest
    public static void testRestrictContactByNameMethod () {
        
        List<Contact> cList = new List<Contact>();
        Contact c1 = new Contact(LastName = 'INVALIDNAME');
        Contact c2 = new Contact(LastName = 'unINVALIDNAME');
        
        cList.add(c1);
        cList.add(c2);
        
        Test.startTest();
        Database.SaveResult[] result = Database.insert(cList, false);
        Test.stopTest();
        
        c2.LastName = 'INVALIDNAME';
        Database.SaveResult result2 = Database.update(c2, false);
    }
}