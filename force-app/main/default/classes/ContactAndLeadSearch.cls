public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads (String str) {
        
        List<List< SObject>> objList = [FIND :str IN ALL FIELDS 
                                       RETURNING contact(lastName, firstName), lead(lastName, firstName)];
        
        return objList;
    }
}