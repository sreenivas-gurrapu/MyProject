/* @RestResource is used to tell the apex that this class is exposing/consuming the Salesforce API
    urlMapping - URL of the API that will be used to hit the APEX REST
*/

@RestResource(urlMapping='/v1/Students/*')
global class StudentController {

    // GET request
    @HttpGet
    global static List<Student__c> getWidgets() {
        List<Student__c> widgets = [SELECT Id, Name from Student__c];
        return widgets;
    }
    
    // POST request to create the Student into System
    @HttpPost 
    global static Student__c createNewWidget(String Name) {
        Student__c student = new Student__c();
        student.Name = Name;
        insert student;
        String returnMesasge = 'You have successfully created a Student into Salesforce - '+'Record Id of the record is - '+student.id;
        //return 'Created '+returnMesasge;
        return [Select Id, Name, Owner.Name From Student__c Where Id=:student.id];
   }

    // Delete to delete the given Student
    @HttpDelete
    global static String deleteWidgetById() {
        String Id = RestContext.request.params.get('Id');
        List<Student__c> w = [ Select ID from Student__c where Id= :Id];

        delete w;

        return 'Deleted Student';
    }

    // Update the Student Record
    @HttpPut
    global static String updateWidget(String Id) {
        Student__c stnd = [ Select ID, Name from Student__c where Id= :Id];

        stnd.Name = 'Sreenivas NewName';
        update stnd;

        return 'Widget Student';
    }
}