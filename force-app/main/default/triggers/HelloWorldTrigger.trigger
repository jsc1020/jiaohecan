trigger HelloWorldTrigger on Account (before update) {
    System.debug('Hello World!');
    for(Account a : Trigger.New) {
        system.debug('new:' + a.Hello__c);
    }
    
    for(Account b : Trigger.Old) {
        system.debug('old:' + b.Hello__c);
    }
}