const String tradeasiaApi = "http://tradeasia.sg/en";
const String dhlApiKey = "PmEGPG6egTkieQW6tCo5v5GGRPGNAzG2";
const String faqApi = "https://tradeasia.sg/en/faq";
const String salesforceDataApi =
    "https://tradeasia--newmind.sandbox.my.salesforce.com/services/data/v58.0/queryAll?q=Select Id, Name, Phone From Account";
// const String salesforceCPQuery =
//     "SELECT Id, CreatedById, LastModifiedById, Opportunity__c, X1st_Sector_BL_No__c, Sailing_On_About__c, Remarks__c, Quantity__c, UOM__c, Product_Name__c, Unit_Price_UOM__c, Total_Price__c, Inv_No__c, Inv_Date__c, B_L_No__c, Shipper_Bank__c, Vessel_VOY_No__c, Description_of_Goods__c, PI_No__c, Remarks_Packing_List__c, Account_Name_Backend__c, Consigned_Sold_To__c, Applicant_Name_and_Address__c, Packing_List__c, B_L_Date__c, Authorized_Signatory__c, Drawee__c, Freight_Charges_SI__c, Remarks_PL__c, Country_of_Origin__c, Quantity_Per_Container__c, Total_of_Containers__c, CI__c, ETA_estimated_Date_of_Arrival__c, Booking_Nmbr_auto__c, Amount_Insured__c, Rate__c, Premium_Amount__c, Stamp_Duty__c, Total_Insurance_Amount__c, Container_Size__c, Vessel_Label__c, Total_Price_words__c, Acceptance__c, Country_of_Final_Destination__c, Tenor__c, Business_Entity__c, SUBJECT_For_Shipping_Advise__c, Worked_By__c, STATUS__c, AWB_NO__c, BL_Auto_generated_Number__c, Status_Deal__c, Total_Advance_Payment__c, Total_AMOUNT_includng_all_charges__c, Amount_after_reducing_advance__c, Account__c, Xero_Desc__c, Payment_Status__c, Bank_Account__c, Bank_Reference_No__c, Remarks_for_Financing__c, Interest_Amount__c, Received_Amount__c, Discounted_Amount__c, Received_Date__c, Balance_Amount__c, Credit_Limit__c, Tax__c, Total_Price_INR_words__c, With_House_B_L_No__c, Account_Address__c, Today__c, Total_Agent_Commission__c, Total_Brokerage_Charge__c, Indicative_Due_Date__c, Amount_after_deducting_advance__c, Carrier_Name__c, Total_Amount_Excluding_Tax__c, Total_Amount_incl_Tax_In_Words__c, Total_amount_after_tax__c, Tax_Amount_Backend__c, Total_AMOUNT_including_all_charges_Bac__c, OverDue_Days_Indonesia__c, Due_Date__c, Remaining_Payment__c, Late_Days__c, Total_Purchase__c, Total_Purchase_Price__c, Total_Purchase_SO__c, AWB_Service__c, Profit_Margin__c, AWB_Origin_Address__c, AWB_Destination_Address__c, AWB_Current_Status__c, AWB_Current_Location__c, AWB_Status_Description__c, AWB_Last_Status_Updated__c From Cost_Price__c WHERE ((Id = 'a0N8G000002eZTc'))";
const String chemtradeasiaUrl = "https://chemtradea.chemtradeasia.com/";
const String salesforceCustomerTypeId = "012j0000000kpTYAAY";
const String salesforceAgentTypeId = "012j0000000m8aQAAQ";

String salesforceCPQuery(String id) {
  return "SELECT Id, CreatedById, LastModifiedById, Opportunity__c, X1st_Sector_BL_No__c, Sailing_On_About__c, Remarks__c, Quantity__c, UOM__c, Product_Name__c, Unit_Price_UOM__c, Total_Price__c, Inv_No__c, Inv_Date__c, B_L_No__c, Shipper_Bank__c, Vessel_VOY_No__c, Description_of_Goods__c, PI_No__c, Remarks_Packing_List__c, Account_Name_Backend__c, Consigned_Sold_To__c, Applicant_Name_and_Address__c, Packing_List__c, B_L_Date__c, Authorized_Signatory__c, Drawee__c, Freight_Charges_SI__c, Remarks_PL__c, Country_of_Origin__c, Quantity_Per_Container__c, Total_of_Containers__c, CI__c, ETA_estimated_Date_of_Arrival__c, Booking_Nmbr_auto__c, Amount_Insured__c, Rate__c, Premium_Amount__c, Stamp_Duty__c, Total_Insurance_Amount__c, Container_Size__c, Vessel_Label__c, Total_Price_words__c, Acceptance__c, Country_of_Final_Destination__c, Tenor__c, Business_Entity__c, SUBJECT_For_Shipping_Advise__c, Worked_By__c, STATUS__c, AWB_NO__c, BL_Auto_generated_Number__c, Status_Deal__c, Total_Advance_Payment__c, Total_AMOUNT_includng_all_charges__c, Amount_after_reducing_advance__c, Account__c, Xero_Desc__c, Payment_Status__c, Bank_Account__c, Bank_Reference_No__c, Remarks_for_Financing__c, Interest_Amount__c, Received_Amount__c, Discounted_Amount__c, Received_Date__c, Balance_Amount__c, Credit_Limit__c, Tax__c, Total_Price_INR_words__c, With_House_B_L_No__c, Account_Address__c, Today__c, Total_Agent_Commission__c, Total_Brokerage_Charge__c, Indicative_Due_Date__c, Amount_after_deducting_advance__c, Carrier_Name__c, Total_Amount_Excluding_Tax__c, Total_Amount_incl_Tax_In_Words__c, Total_amount_after_tax__c, Tax_Amount_Backend__c, Total_AMOUNT_including_all_charges_Bac__c, OverDue_Days_Indonesia__c, Due_Date__c, Remaining_Payment__c, Late_Days__c, Total_Purchase__c, Total_Purchase_Price__c, Total_Purchase_SO__c, AWB_Service__c, Profit_Margin__c, AWB_Origin_Address__c, AWB_Destination_Address__c, AWB_Current_Status__c, AWB_Current_Location__c, AWB_Status_Description__c, AWB_Last_Status_Updated__c From Cost_Price__c WHERE ((Account__c = '$id'))";
}

String salesforceOpportunityQuery(String id) {
  return "Select Id, Name, AccountId, Account.Name, Product_Name__c, Product_Name__r.Name, UOM__c, Quantity__c, Delivery_Term__c,StageName,ForecastCategoryName,CloseDate,Worked_by__c,Origin__c,Description_of_Goods__c,Packaging_Details__c,H_S_Code__c,Total_of_Containers__c,Container_Size__c,Port_of_Discharge__c,Business_Entity__c From Opportunity WHERE ((AccountId = '$id'))";
}
