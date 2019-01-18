public with sharing class WarehouseCalloutService {
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';   
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future (callout = true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
        HttpRequest hrq = new HttpRequest();
        hrq.setEndpoint(warehouse_url);
        hrq.setMethod('GET');
        HttpResponse Hr = http.send(hrq);
        if(hr.getStatusCode()==200)
        {
			List<Equipment> equip = (List<Equipment>)JSON.deserialize(hr.getBody(),List<Equipment>.Class);
            List<Product2> UpsertProduct = new List<product2>();
            for (Equipment pr : equip)
            {
                Product2 prd = new Product2(Replacement_Part__c = pr.Replacement, Current_Inventory__c = pr.quantity,
                Name = pr.name,Maintenance_Cycle__c = pr.maintenanceperiod,
                Lifespan_Months__c = pr.Lifespan,Cost__c = pr.Cost,Warehouse_SKU__c = pr.sku,
                id = pr.id);
                UpsertProduct.add(prd);
            }
            system.debug(UpsertProduct);
            upsert UpsertProduct;
        }

    }
        
    class Equipment{
        public Id id{get;set;}
        public boolean replacement{get;set;}
        public Integer quantity{get;set;}
        public String name{get;set;}
        public Decimal maintenanceperiod{get;set;}
        public Decimal lifespan{get;set;}
        public Decimal cost{get;set;}
        public String sku{get;set;}
    }

}