public with sharing class Accountactionhandler {
    Public static void createcontact(List<account>accountList){
        List<contact>contactList = new List<contact>();
        for(Account actobj:accountList){
            contact conobj= new contact();
            conobj.AccountId = actobj.id;
            conobj.LastName = actobj.Name;
            contactList.add(conobj);

        }
        if(!contactList.isEmpty()){
            insert contactList;


        }
 
        }
        Public static void Createopportunity(Map<Id,Account> actnewmap,Map<Id,Account> actoldmap){
            List<opportunity> opportunityList = new List<opportunity>();
            for(Account actobj:actnewmap.values()){
        if(actnewmap.get(actobj.Id).Rating!=actoldmap.get(actobj.Id).Rating 
        && actnewmap.get(actobj.Id).Rating== 'warm'){
                opportunity oppobj = new Opportunity();
                oppobj.AccountId = actobj.Id;
                oppobj.Name = actobj.Name;
                oppobj.StageName = 'Prospect';
                oppobj.Closedate = system.today();
                opportunityList.add(oppobj);
}

}
if(!opportunityList.isEmpty()){
    insert opportunityList;
}
            }

 Public static void validateAccountbeforeinsert(List<account>accountList){
     for(Account actobj:accountList){
         if(actobj.Rating=='Hot' && actobj.Type ==null){
             actobj.addError('Account Type is mandatory');
         }
     }

 }
 Public static void preventAccountDeletion(List<account> accountList){
     Set<Id> accountIdset = new Set<id>();
     Map<Id,Boolean> accountIdisprimaryMap = new Map<Id,Boolean>();
     //Preparation of AccountIdset
     for(Account actobj:accountList){
        accountIdset.add(actobj.id);

     }
     //Prepartion of Map
     if(accountIdset!=null && accountIdset.size()>0){
         for(contact conobj:[Select id,IsPrimary__c	,accountId From contact 
         where accountId in:accountIdset and IsPrimary__c =true ]){
            accountIdisprimaryMap.Put(conobj.accountId,conobj.IsPrimary__c);

         }
     }
     //Start validating and prevent 
     for(Account actobj:accountList){
         if(accountIdisprimaryMap.get(actobj.Id)!=null && accountIdisprimaryMap.get(actobj.Id)==true){
             actobj.addError('you can\'t delete account');

         }

     }

 }

        }