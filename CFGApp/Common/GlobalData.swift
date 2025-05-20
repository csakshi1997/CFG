//
//  GlobalData.swift
//  CFGApp
//
//  Created by Sakshi on 28/01/25.
//

import Foundation
import UIKit

class GlobalData: NSObject {
    static var allPatientData = [PatientModel]()
    static var patientDetailData = [PatientDetailModel]()
    static var allpendingMaintenanceModel = [PendingMaintenanceModel]()
    static var allClosedMaintenanceModel = [ClosedMaintenanceModel]()
    static var allClinicModel = [ClinicModel]()
    static var allDoctorModel = [DoctorModel]()
    static var allPendingRedFlagModel = [PendingRedFlagModel]()
    static var allClosingRedFlagModel = [ClosingRedFlagModel]()
    static var allPendingRefundModel = [PendingRefundModel]()
    static var allClosingRefundModel = [ClosingRefundModel]()
 }

