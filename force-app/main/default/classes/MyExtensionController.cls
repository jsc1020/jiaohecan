public class MyExtensionController
{
    private final Account myAccount;
    
    public MyExtensionController(ApexPages.StandardController stdController)
    {
        this.myAccount= (Account)stdController.getRecord();
    }
    
    public String getGreeting()
    {
        return 'Hello ' + myAccount.name + ' (' + myAccount.id + ')';
    }
}