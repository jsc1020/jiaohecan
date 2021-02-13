public class MyAccountController{
    private final Account account;
    public MyAccountController() {
        Id id = ApexPages.currentPage().getParameters().get('id');
        account = (id == null) ? new Account() :
                    [SELECT Id, Name, Site, Phone FROM Account
                    WHERE Id = :id];
    }
    public Account getAccount() {
        return account;
    }
    public PageReference save() {
        try
        {
            upsert account;
        }
        catch(System.DMLException e)
        {
            ApexPages.addMessages(e);
            return null;
        }
        PageReference redirectSuccess = new ApexPages.StandardController(Account).view();
        return (redirectSuccess);
    }
}