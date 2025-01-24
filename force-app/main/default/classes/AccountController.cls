@AuraEnabled
public class AccountController 
{
    @AuraEnabled
    public 
    static List<Account> getAllAccounts() 
    {
// this comment has weird indentation
                                // this comment has weird indentation as well
        return [SELECT Id, Name FROM Account] ;
    }

    @AuraEnabled
    public 
    static List<Account> getAccountsByName( String name ) 
    {
        // if name is null or empty, return all accounts
        if (String.isBlank( name )) 
        {
            return getAllAccounts() ;
        }
        return [SELECT Id, Name FROM Account WHERE Name LIKE :name];
    }

    @AuraEnabled
    public static Id createAccount( Account account ) 
    {
        try 
        {

            Database.SaveResult result = Database.insert( account, true ) ;
            
            if (!result.isSuccess()) 
            {

                System.debug('Error creating account: ' + result.getErrors()[0].getMessage());
                
                throw new AuraHandledException('Error creating account: ' + result.getErrors()[0].getMessage());
            }

            return result.getId();
        } 
        catch (DmlException e) 
        {
            System.debug('Error creating account: ' + e.getMessage());
            throw new AuraHandledException('Error creating account: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteAccount( Id accountId ) {
        try {
            Database.DeleteResult result = Database.delete(accountId, true);
            if (!result.isSuccess()) {
                System.debug('Error deleting account: ' + result.getErrors()[0].getMessage());
                throw new AuraHandledException('Error deleting account: ' + result.getErrors()[0].getMessage());
            }
        } 
        catch (DmlException e) {
            System.debug('Error deleting account: ' + e.getMessage());
            throw new AuraHandledException('Error deleting account: ' + e.getMessage());
        }
    }
  }
