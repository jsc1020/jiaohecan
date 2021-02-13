trigger RestrictContactByName on Contact (before insert, before update) {

    for (Contact c : Trigger.New) {
        
        if ('INVALIDNAME' == c.LastName) {
            
            c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
        }
    }
}