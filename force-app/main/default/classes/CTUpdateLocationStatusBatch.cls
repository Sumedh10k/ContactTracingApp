public with sharing class CTUpdateLocationStatusBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start (Database.BatchableContext BC){
        List<String> healthStatuses = new List<String>{'Red', 'Orange','Yellow'};
        Date today = Date.today();
        Date fourteenDaysAgo = today - 14;
        return Database.getQueryLocator('SELECT Id , Status__c FROM Location_c WHERE Status_Update__c =: fourteenDaysAgo AND Status__c IN : healthStatuses ');
    }

    public void execute(Database.batchableContext BC, List<Location__c> scope){
        for(Location__c person : scope){
            person.Status__c = 'Green';
        }
        update scope;
    }

    public void finish (Database.BatchableContext BC){
        //batch is completed
    }
}