global class MySchedulableClass implements Schedulable {
    global void execute(SchedulableContext ctx) {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                          FROM CronTrigger 
                          WHERE Id = :ctx.getTriggerId()];
        System.debug(ct.CronExpression);
        System.debug(ct.TimesTriggered);
        Prodcut__c m = new Prodcut__c(
            Name='Scheduled Job Item',
            StockQuantity__c=1000,
            SalesPrice__c=1000);
        insert m;
    }
}