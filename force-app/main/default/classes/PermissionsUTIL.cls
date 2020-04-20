/**
 * @description     fls / crud check utility class
 * @author          daniel@hyphen8.com
 * @date            30/05/2019
 * @group           Utility Class
 */

public with sharing class PermissionsUTIL {

    /**
     * @description     method to check if the current object has access to object / fields
     * !TODO            potentially this can be depreciated with the new CRUD method coming in
     * @param           string sobjectName the object we want to check
     * @param           List<String> fields a string list of field api names we want to check
     * @return          boolean confirm yes or no the user has access
    */ 
    public static Boolean isAccessible(String sobjectName, List<String> fields ) {
        String[] sObjectNames = new String[] { sobjectName };
        Schema.DescribeSObjectResult[] dResult = Schema.describeSObjects(sObjectNames);
        if ( dResult[0].isAccessible() ) {
            if(!fields.IsEmpty()){
                Map<String,Schema.SObjectField> fieldMap = dResult[0].fields.getMap();
                for ( String fieldToCheck : fields ) {
                    if ( !fieldMap.get( fieldToCheck ).getDescribe().isAccessible()) {
                        return false;
                    }
                }
                return true;
            } else {
                return true;
            }
        } else {
            return false;
        }
    }

    /**
     * @description     method to confirm if the current user can create against specific object and fields
     * !TODO            potentially depreciate this with the latest API apex methods for security checkings
     * @param           string sobjectName is the object we want to check
     * @param           List<String> fields are a list of the field API names we want to check for access to
     * @return          boolean confirming yes or no for user access 
    */
    public static Boolean isCreateable( string sobjectName, List<String> fields ) {
        String[] sObjectNames = new String[] { sobjectName };
        Schema.DescribeSObjectResult[] dResult = Schema.describeSObjects(sObjectNames);
        if ( dResult[0].isCreateable() ) {
            Map<String,Schema.SObjectField> fieldMap = dResult[0].fields.getMap();
            for ( String fieldToCheck : fields ) {
                if ( !fieldMap.get( fieldToCheck ).getDescribe().isCreateable()) {
                    return false;
                }
            }
            return true;
        } else {
            return false;
        }
    }


    /**
     * @description     method to confirm if the current user can update against specific object and fields
     * !TODO            potentially depreciate this with the latest API apex methods for security checkings
     * @param           string sobjectName is the object we want to check
     * @param           List<String> fields are a list of the field API names we want to check for access to
     * @return          boolean confirming yes or no for user access 
    */
    public static Boolean isUpdateable( string sobjectName, List<String> fields ) {
        String[] sObjectNames = new String[] { sobjectName };
        Schema.DescribeSObjectResult[] dResult = Schema.describeSObjects(sObjectNames);
        if ( dResult[0].isUpdateable() ) {
            Map<String,Schema.SObjectField> fieldMap = dResult[0].fields.getMap();
            for ( String fieldToCheck : fields ) {
                if ( !fieldMap.get(  fieldToCheck ).getDescribe().isUpdateable()) {
                    return false;
                }
            }
            return true;
        } else {
            return false;
        }
    }


    /**
     * @description     method to confirm if the current user can delete against specific object and fields
     * !TODO            potentially depreciate this with the latest API apex methods for security checkings
     * @param           string sobjectName is the object we want to check
     * @param           List<String> fields are a list of the field API names we want to check for access to
     * @return          boolean confirming yes or no for user access 
    */
    public static Boolean isDeletable( string sobjectName ) {
        String[] sObjectNames = new String[] { sobjectName };
        Schema.DescribeSObjectResult[] dResult = Schema.describeSObjects(sObjectNames);
        if ( dResult[0].isDeletable()) {
            return true;
        } else {
            return false;
        }
    }
}