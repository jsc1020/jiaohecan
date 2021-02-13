public class findHitachiAccounts {
    private final List<Account> accounts;
    public findHitachiAccounts() {
        accounts = [select Name from Account where Name LIKE '八%'];
    }
    public List<Account> getHitachiAccounts() {
        return accounts;
    }
}