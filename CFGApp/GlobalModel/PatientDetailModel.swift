//
//  PatientDetailModel.swift
//  CFGApp
//
//  Created by Sakshi on 12/02/25.
//

struct PatientDetailModel {
    var passport: String?
    var name: String?
    var healthClassList: [HealthClass]?
    var doctorName: String?
    var doctorId: String?
    var contactNumber: String?
    var clinicName: String?
    var clinicId: String?

    struct HealthClass {
        let planName: String
        let frequency: String
        let financialBalance: String
        let dateOfPurchase: String
        let healthCardNumber: String
        let healthCardId: String
        let subsidyPlanType: String
        let subsidyPlanList: [SubsidyPlan] 

        init(dict: [String: Any]) {
            print(dict)
            print("Type of FinancialBalance:", type(of: dict["FinancialBalance"] ?? "nil"))
            self.planName = dict["PlanName"] as? String ?? ""
            self.frequency = dict["Frequency"] as? String ?? ""
            self.financialBalance = dict["FinancialBalance"] as? String ?? ""
            self.dateOfPurchase = dict["DateOfPurchase"] as? String ?? ""
            self.healthCardNumber = dict["HealthCardNumber"] as? String ?? ""
            self.healthCardId = dict["HealthCardId"] as? String ?? ""
            self.subsidyPlanType = dict["SubsidyPlanType"] as? String ?? ""

            if let plans = dict["SubsidyPlanList"] as? [[String: Any]], !plans.isEmpty {
                print("✅ Found SubsidyPlanList with \(plans.count) items")
                self.subsidyPlanList = plans.compactMap { SubsidyPlan(dict: $0) }
            } else {
                print("❌ No SubsidyPlan found for HealthCardId: \(self.healthCardId)")
                self.subsidyPlanList = [] // Ensure empty array if no subsidy plans exist
            }
        }
    }

    struct SubsidyPlan {
        let id: String
        let healthCardId: String
        let subsidyPlanName: String
        let type: String
        let url: String

        init(dict: [String: Any]) {
            print("🔍 Parsing SubsidyPlan:", dict)

            self.id = dict["Id"] as? String ?? ""
            self.healthCardId = dict["Health_Card__c"] as? String ?? ""

            // Check for nested dictionary safely
            if let subsidyPlanDict = dict["Subsidy_Plan_Name__r"] as? [String: Any] {
                self.subsidyPlanName = subsidyPlanDict["Name"] as? String ?? ""
            } else {
                self.subsidyPlanName = ""
                print("⚠️ Missing Subsidy_Plan_Name__r")
            }

            if let attributesDict = dict["attributes"] as? [String: Any] {
                self.type = attributesDict["type"] as? String ?? ""
                self.url = attributesDict["url"] as? String ?? ""
            } else {
                self.type = ""
                self.url = ""
                print("⚠️ Missing attributes")
            }
        }
    }

    init(dict: [String: Any]) {
        self.passport = dict["Passport"] as? String
        self.name = dict["Name"] as? String
        self.doctorName = dict["DoctorName"] as? String
        self.doctorId = dict["DoctorId"] as? String
        self.contactNumber = dict["ContactNumber"] as? String
        self.clinicName = dict["ClinicName"] as? String
        self.clinicId = dict["ClinicId"] as? String

        if let healthList = dict["HealthClassList"] as? [[String: Any]], !healthList.isEmpty {
            print("✅ Found HealthClassList with \(healthList.count) items")
            self.healthClassList = healthList.compactMap { HealthClass(dict: $0) }
        } else {
            print("❌ No HealthClassList found")
            self.healthClassList = [] 
        }
    }
}
