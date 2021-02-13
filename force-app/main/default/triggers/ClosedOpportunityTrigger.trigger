trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    /**
    List<task> taskList = new List<task>();
    
    for (opportunity o : [SELECT Id 
                          FROM opportunity 
                          WHERE Id IN :Trigger.New 
                          AND StageName = 'Closed Won']) {
                              
                              task t = new task();
                              t.Subject = 'Follow Up Test Task';
                              t.WhatId = o.Id;
                              
                              taskList.add(t);
    }
    
    if (taskList.size() > 0) {
        
        insert taskList;
    }
*/
}