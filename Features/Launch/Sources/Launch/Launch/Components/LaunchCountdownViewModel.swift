import Foundation
import TrackXClient

// MARK: - LaunchCountdownViewModel

struct LaunchCountdownViewModel: Hashable {
    
    struct TimeUnitModel: Hashable {
        
        let time: String
        let unit: String
        
    }
    
    // MARK: - Lifecycle
    
    public init(launch: LaunchModel) {
        self.launch = launch
        timeUnitModels = [
            TimeUnitModel(time: "13", unit: "days"),
            TimeUnitModel(time: "19", unit: "hours"),
            TimeUnitModel(time: "57", unit: "mins")
        ]
    }
    
    // MARK: - Internal
    
    let launch: LaunchModel
    let name: String = "T-Minus"
    let timeUnitModels: [TimeUnitModel]

}
