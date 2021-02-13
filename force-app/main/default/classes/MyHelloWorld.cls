public class MyHelloWorld {
    // このメソッドは取引先のリストで [Hello] 項目を更新する
    public static void addHelloWorld(Account[] accs){
        for (Account a:accs){ 
            if (a.Hello__c != 'World'){
                a.Hello__c = 'World';
            }
        }
    }
    
    public static void updateHelloWorld(Account[] accs){
        for (Account a:accs){ 
            if (a.Hello__c != 'HelloWorld'){
                a.Hello__c = 'HelloWorld';
            }
        }
    }
}