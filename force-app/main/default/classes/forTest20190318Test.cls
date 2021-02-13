@isTest
public class forTest20190318Test {

    @isTest
    public static void testA_Test () {
        
        List<Account> fList = new List <Account> ();
        
        For(integer i= 1; I <= 200; i++){
            fList.add(new Account ( Name = 'Universal Account' + i));
        }
        Insert fList;
        
        List <Account> sList = new List<Account>();
        
        For (integer I = 201; I <= 2000; i ++){
            sList.add(new Account (Name = 'Universal Account' + i));
        }
        
        Insert sList;
        
                
        system.debug('fList.size' + fList.size());
        system.debug('sList.size' + sList.size());
    }
}