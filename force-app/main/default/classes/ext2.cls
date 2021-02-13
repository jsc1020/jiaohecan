public class ext2 {

    private final Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public ext2(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }

    public String getGreeting() {
        return '真好 ' + acct.name + ' (' + acct.id + ')';
    }
}