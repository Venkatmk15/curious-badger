public class MaintenanceRequestHelper {    
    public static void updateWorkOrders(List<case> closedCases)
    {
        List<case> newCases = new List<case>();  
        
        for(Case c : closedcases)
        {
            integer duedate = 0;
            for(work_part__c wp : c.work_parts__r)
            {
                system.debug('Maintenance Cycle value is' + wp.equipment__R.maintenance_cycle__C);
            	duedate =  wp.equipment__R.maintenance_cycle__C== Null ? 10 : Integer.valueof(wp.equipment__R.maintenance_cycle__C);
                system.debug(duedate);
            }
         case Assigncase = new case(Vehicle__c = c.Vehicle__c, 
          Type = 'Routine Maintenance', 	
          Subject =  string.isBlank(c.Subject)?'Routine Maintenance Request': c.Subject,
          Date_Reported__c = Date.today(), Date_Due__c = Date.today().adddays(duedate),
          Equipment__c = c.Equipment__c);
         newCases.add(Assigncase);
        }
        system.debug(newcases);
        if(newcases.size() > 0)
        {
       	 insert newCases;  
        }
    }        
    
}