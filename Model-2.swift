
import Foundation

typealias PersonType = Person.PersonType

//MARK: Person Model
class CitsEvent {
    
    let createdDateTime: Date
    let updatedDateTime: Date
    
    init (_ createdDateTime: Date, updatedDateTime: Date) {
        
        self.createdDateTime = createdDateTime
        self.updatedDateTime = updatedDateTime
        
    }
    
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
    
}


//MARK: Person Model
class Person {
    
    enum PersonType {
        case Student
        case Trainer
    }
    
    let personId: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let personType: PersonType
    let event: CitsEvent?

    
    init(_ personId: String, _ firstName: String, _ lastName: String,_ phoneNumber: String, _ personType: PersonType , _ event: CitsEvent? ) {
        
        self.personId = personId
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.personType = personType
        self.event = event
    }

    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }

    
}

//Person extension
extension Person {
    //add any methods here or computed properties.
    
}



//MARK: Profile Model
class Profile {
    
    var person: Person?
    var personId: String
    var profileId: Int?
    var skillSet: [String]?
    var mailId: String
    var profileImageUrl: String
    var event : CitsEvent?

    init(_ person: Person?, _ profileId: Int?, _ skillSet: [String] = [""], _ mailId: String = "", _ profileImageUrl: String = "", _ event: CitsEvent?) {
        
        self.person = person
        self.personId = person?.personId ?? ""
        self.profileId = profileId
        self.skillSet = skillSet
        self.mailId = mailId
        self.profileImageUrl = profileImageUrl
        self.event = event
    }
    
    convenience init(_ person: Person?, _ skillSet: [String] = [""],_ mailId: String = "",_ profileImageUrl: String = "",_ event: CitsEvent?) {
        
        self.init(person,nil,skillSet,mailId,profileImageUrl,event)
        
    }
    
    
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
    
    
   }

//MARK: Profile extension
extension Profile {
    
    //add any methods here or computed properties.

}

//MARK: Group Model
class Group {
    
    enum GroupType {
        
        case online
        case classRoom
    }
    
    var groupId: Int?
    var groupName: String
    var groupDescription: String
    var groupType: GroupType
    var personIds: [String] //They are personId's and in future we could have more than one admin's for a for a group
    var event : CitsEvent?

    

    init(_ groupId: Int?, _ groupName: String, _ groupDescription: String,  adminId personIds: [String],_ groupType: GroupType, _ event: CitsEvent) {
        
        self.groupId = groupId
        self.groupName = groupName
        self.groupDescription = groupDescription
        self.groupType = groupType
        self.personIds = personIds
        self.event = event
    
    }
    
    
    convenience init(_ groupName: String, _ groupDescription: String, adminId personIds: [String],_ groupType: GroupType, _ event: CitsEvent) {
        
        self.init(nil,groupName,groupDescription,adminId:personIds,groupType,event)
        
    }
    
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
   
   
}

//MARK: Group extension
extension Group{
    //add any methods here or computed properties.
}


//MARK: UsersGroup Model
class UsersGroup {
    
    var person: Person?
    var personId:String
    var groupId:Int
    var personType:Person.PersonType
    
    
    init(_ personId:String,_ groupId: Int, _ personType: PersonType) {
        
        self.personId = personId
        self.groupId = groupId
        self.personType = personType
        
    }
    
    init (_ person: Person,_ groupId: Int, _ personType: PersonType)
    {
        self.person = person
        self.personId = person.personId
        self.groupId = groupId
        self.personType = personType
        
        
    }

    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
    
}

//MARK: UsersGroup extension
extension UsersGroup{
    //add any methods here or computed properties.
}

//MARK: Session Model
class Session {
    
    let sessionId: Int?
    var name: String
    var dateTime: Date
    var latitude: Double
    var longitude: Double
    var type: String
    var event: CitsEvent
    
    init(id: Int?,name: String,dateTime: Date, location latitude: Double,location longitude: Double, type: String, on event: CitsEvent) {
        
        self.sessionId = id
        self.name = name
        self.dateTime = dateTime
        self.latitude = latitude
        self.longitude = longitude
        self.type = type
        self.event = event
        
    }
    
    
    convenience  init(name: String,dateTime: Date, location latitude: Double,location longitude: Double, type: String, on event: CitsEvent) {
        
        self.init(id: nil,name: name,dateTime: dateTime,location: latitude,location: longitude,type: type,on: event)
        
    }
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
    
}

//MARK: Session extension
extension Session{
    
      //add any methods here or computed properties.
}

//MARK: SessionMaterial Model
class SessionMaterial {
    
    let session: Session
    let materialId: Int
    var materialName: String
    var materialUrl: String
    let uploadedDate: Date
    let fileType: String
    let fileSize: String
    
    init( _ session: Session ,id materialId: Int, name materialName: String, url materialUrl: String,on uploadedDate:Date,_ fileType:String, _ fileSize:String ) {
        
        self.session = session
        self.materialId = materialId
        self.materialName = materialName
        self.materialUrl = materialUrl
        self.uploadedDate = uploadedDate
        self.fileType = fileType
        self.fileSize = fileSize
    }
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
    
   }

//MARK: SessionMaterial extension
extension SessionMaterial{
          //add any methods here or computed properties.
}


//MARK: User Session Model
class UserSession {
    var person:Person
    var sessionId:Int
    
    init(_ person: Person, _ sessionId: Int) {
        self.person = person
        self.sessionId = sessionId
    }
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
}


//MARK: Session Members
class SessionMembers {
    
    let session: Session?
    let personId: String
    let personType: PersonType
    let mailId: String
    
    init(_ session: Session?,_ personId: String, _ personType: PersonType, _ mailId: String) {
        
        self.session = session
        self.personId = personId
        self.personType = personType
        self.mailId = mailId
    }
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
}

//MARK: UserSession extension
extension UserSession{
    //add any methods here or computed properties.
}

//MARK: UserRequests Model
class UserRequests {
    
    enum RequestType {
        
        case reqToJoinGroup
        case reqToJoinSession
        case inviteToJoinSession
        case inviteToJoinGroup
        
    }
    
    var requestor: Person?
    var receiver: Person?
    var session: Session?
    let requestId: Int?
    var group: Group
    let requestorId: String
    let receiverId: String
    var requestType: RequestType
    
    init(_ requestId: Int?,_ requestor: Person, _ receiver: Person ,_ session: Session,_ group:Group, _ requestType: RequestType) {
        
        self.requestor = requestor
        self.receiver = receiver
        self.session = session
        self.group = group
        self.requestId = requestId
        self.requestorId = requestor.personId
        self.receiverId = receiver.personId
        self.requestType = requestType
        
    }
    
    convenience init(_ requestor: Person, _ receiver: Person ,_ session: Session,_ group:Group, _ requestType: RequestType) {
        
        self.init (nil,requestor,receiver,session,group,requestType)
        
    }
    
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
}

//MARK: UserRequests extension
extension UserRequests{
    //add any methods here or computed properties.
}


//MARK: UserActivity Model
class UserActivity {
    
    let person: Person
    let personId: String
    let activityId:Int?
    let activityTime:String
    let activity:Activity
    let session: Session
    
    init(_ activityId: Int?,_ person: Person , _ activityTime: String, _ activity: Activity, _ session: Session) {
        
        self.activityId = activityId
        self.person = person
        self.personId = person.personId
        self.activityTime = activityTime
        self.activity = activity
        self.session = session
        
        
    }
    
    convenience init( _ person: Person ,_ activityTime: String, _ activity: Activity, _ session : Session) {
        
        self.init(nil,person,activityTime,activity,session)
        
    }
    
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
    
}

//MARK: UserActivity extension
extension UserActivity{
    //add any methods here or computed properties.
}


//MARK: Activity Model
class Activity {
    
    enum ActivityType {
        case uploadedMaterial
    }
    
    let activityType: ActivityType
    let activityTime: String
    let activityDescription: String
   
    init(_ activityType: ActivityType, _ activityTime: String, _ activityDescription: String) {
        self.activityType = activityType
        self.activityTime = activityTime
        self.activityDescription = activityDescription
    }
    
    required init(withData: Any?) throws {
        guard let _  = withData else {
            return
        }
    }
    
}

//MARK: Activity extension
extension Activity{
    //add any methods here or computed properties.
}







