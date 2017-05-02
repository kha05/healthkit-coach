import Foundation
import HealthKit

class HealthManager {
  let healthKitStore : HKHealthStore = HKHealthStore()

  func authorizeHealthKit(completion: ((_ success:Bool , _ error:NSError?) -> Void)!) {

    let healthKitTypeToRead = Set(arrayLiteral: [
      HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifierDateOfBirth),
      HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifierBloodType),
      HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifierBiologicalSex),
      HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifierBodyMass),
      HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifierHeight),
    ])

    let healthKitTypeToWrite = Set(arrayLiteral: [
      HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifierBodyMassIndex),
      HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifierActiveEnergyBurned),
      HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifierDistanceWalkingRunning),
      HKQuantityType.workoutType()
    ])

    if !HKHealthStore.isHealthDataAvailable(){
      let error = NSError(domain: "kevinha.HKTutorial", code: 2, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available in this deivce"])
      if ( completion != nil ){
        completion(success:false,error:error)
      }
      return;
    }

    healthKitStore.requestAuthorization(toShare: healthKitTypeToWrite, read: healthKitTypeToRead) { (completion, error) -> Void in
      if (completion != nil) {
        completion(success:success,error:error)
      }
    }
  }
}
