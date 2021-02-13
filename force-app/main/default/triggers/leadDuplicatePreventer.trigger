trigger leadDuplicatePreventer on Lead (before insert, before update) { 
    Map<String, Lead> leadMap = new Map<String, Lead>();
    for (Lead lead : System.Trigger.new) { 
        // 更新時に変更されない電子メールアドレスは 
        // 重複とみなさないようにする。 
        if ((lead.Email != null) 
            && (System.Trigger.isInsert 
                || (lead.Email != System.Trigger.oldMap.get(lead.Id).Email))) { 
                    // 新たに作成されるリードでも重複がないことを確認する 
                    if (leadMap.containsKey(lead.Email)) { 
                        lead.Email.addError('Another new lead has the ' + 'same email address.'); 
                    } else { 
                        leadMap.put(lead.Email, lead); 
                    } 
                } 
    } 
    // 1 回のデータベースクエリで、 
    // 挿入または更新されたリードのいずれかと同一の 
    // 電子メールアドレスを持つリードをすべて検索する。 
    for (Lead lead : [SELECT Email FROM Lead WHERE Email IN :leadMap.KeySet()]) { 
        Lead newLead = leadMap.get(lead.Email);
        newLead.Email.addError('A lead with this email ' + 'address already exists.'); 
    }
}