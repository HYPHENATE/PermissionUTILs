/**
 * @description     fls / crud check utility test class
 * @author          daniel@hyphen8.com
 * @date            30/05/2019
 * @group           Test classes
 */
@isTest
public with sharing class PermissionsUTIL_Test {

      /**
      * @description    simple test with current user permissions
      **/
      public static testmethod void testAccess() {
        System.assertEquals(true, PermissionsUTIL.isAccessible('Account', new List<String>{'Name', 'Phone'}), 'Current user has access to object and fields');
        System.assertEquals(true, PermissionsUTIL.isAccessible('Account', new List<String>()), 'Current user has access to object');
        System.assertEquals(true, PermissionsUTIL.isUpdateable('Account', new List<String>{'Name', 'Phone'}), 'Current user can update object and fields');
        System.assertNotEquals(true, PermissionsUTIL.isUpdateable('Account', new List<String>{'createddate'}), 'Current user can not update to object and fields');
        System.assertEquals(true, PermissionsUTIL.isCreateable('Account', new List<String>{'Name', 'Phone'}), 'Current user can create to object and fields');
        System.assertNotEquals(true, PermissionsUTIL.isCreateable('Account', new List<String>{'id'}), 'Current user can not create account ID field');
        System.assertEquals(true, PermissionsUTIL.isDeletable('Account'), 'Current user has delete access to object and fields');
      }
  
  
    /**
    * @description  test method with incorrect permissions for user
    **/
    public static testmethod void testwithwrongpermissions()
    {
        // insert a account
        Account account = new Account(Name='Demo');
        insert account;
        // get some strings ready for testing
        ID profileId = [SELECT Id FROM Profile WHERE Name = 'Read Only' LIMIT 1].Id;
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+randomId; 
        User user = new User(
            FirstName = 'DEMO',
            LastName = 'DEMO', 
            Email = uniqueName + '@test' + orgId + '.org', 
            Username = uniqueName + '@test' + orgId + '.org', 
            EmailEncodingKey = 'ISO-8859-1', 
            Alias = uniqueName.substring(18, 23), 
            TimeZoneSidKey = 'GMT',  
            LocaleSidKey = 'en_GB', 
            LanguageLocaleKey = 'en_US', 
            ProfileId  = profileid); 
        insert user;
        system.runas(user){
            System.assertEquals(true, PermissionsUTIL.isAccessible('Account', new List<String>{'Name'}), 'Read only user can read accounts');
            System.assertEquals(true, PermissionsUTIL.isAccessible('Account', new List<String>()), 'Read only user can read accounts');
            System.assertEquals(false, PermissionsUTIL.isAccessible('Account', new List<String>{'AccountNumber'}), 'Read only user can not read this field');
            System.assertEquals(false, PermissionsUTIL.isUpdateable('Account', new List<String>{'Name'}), 'Read only user can not update');
            System.assertEquals(false, PermissionsUTIL.isCreateable('Account', new List<String>{'Name', 'Phone'}), 'Read only user can not create with fields');
            System.assertEquals(false, PermissionsUTIL.isCreateable('Account', new List<String>{'Name'}), 'Read only user can not create');
            System.assertEquals(false, PermissionsUTIL.isDeletable('Account'), 'Read only user can not delete');
        }
    }
  
}