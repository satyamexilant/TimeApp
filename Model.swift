
import Foundation

typealias PersonType = Person.PersonType

//MARK: Person Model
class BVEvent {
    
    let createdDateTime: Date
    var updatedDateTime: Date
    
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
        case student
        case trainer
    }
    
    let prsId: String
    var fName: String
    var lName: String
    var phNo: String
    var pType: PersonType
    var event: BVEvent?

    
    init(personId prsId : String, firstName fName: String, lastName lName: String, phoneNumber phNo: String, personType pType : PersonType , on event: BVEvent? ) {
        
        self.prsId = prsId
        self.fName = fName
        self.lName = lName
        self.phNo = phNo
        self.pType = pType
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
    let personId: String
    var prfId: Int?
    var skills: [String]?
    var mailId: String
    var imgUrl: String
    var event : BVEvent?

    init(_ person: Person?, profileId prfId: Int?, skillSet skills: [String] = [""], emailId mailId: String = "",profileImageUrl imgUrl: String = "", on event: BVEvent?) {
        
        self.person = person
        self.personId = person?.prsId ?? ""
        self.prfId = prfId
        self.skills = skills
        self.mailId = mailId
        self.imgUrl = imgUrl
        self.event = event
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
        
        case publicGroup
        case privateGroup
    }
    
    let grpId: Int?
    var grpName: String
    var grpDescription: String
    var grpType: GroupType
    var personIds: [String] //They are personId's and in future we could have more than one admin's for a for a group
    var event : BVEvent?

    init(groupId grpId: Int?,groupName grpName: String,groupDescription grpDescription: String,  adminIds personIds: [String],ofGroupType grpType: GroupType, on event: BVEvent) {
        
        self.grpId = grpId
        self.grpName = grpName
        self.grpDescription = grpDescription
        self.grpType = grpType
        self.personIds = personIds
        self.event = event
    
    }
    
    
    convenience init(groupName grpName: String,groupDescription grpDescription: String, adminIds personIds: [String],ofGroupType grpType: GroupType, on event: BVEvent) {
        
        self.init(groupId: nil,groupName: grpName, groupDescription: grpDescription,adminIds:personIds,ofGroupType: grpType,on: event)
        
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
    
    let person: Person?
    let prsId:String
    let grpId:Int
    var personType:PersonType
    
    init(personId prsId: String,groupId grpId: Int,ofUserType personType: PersonType) {
        
        self.prsId = prsId
        self.grpId = grpId
        self.personType = personType
        
    }
    
    init (_ person: Person, groupId grpId: Int, ofUserType personType: PersonType)
    {
        self.person = person
        self.prsId = person.prsId
        self.grpId = grpId
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
    
    enum sessionType {
        
        case classRoom
        case online
        
    }
    
    let sessId: Int?
    var name: String
    let dateTime: Date
    let latitude: Double
    let longitude: Double
    var sessionType: sessionType
    let event: BVEvent
    
    init(sessionId sessId: Int?,sessionName name: String,dateTime: Date, location latitude: Double,location longitude: Double, ofType sessionType: sessionType, on event: BVEvent) {
        
        self.sessId = sessId
        self.name = name
        self.dateTime = dateTime
        self.latitude = latitude
        self.longitude = longitude
        self.sessionType = sessionType
        self.event = event
        
    }
    
    
    convenience  init(name: String,dateTime: Date, location latitude: Double,location longitude: Double, ofType sessionType: sessionType, on event: BVEvent) {
        
        self.init(sessionId: nil,sessionName: name,dateTime: dateTime,location: latitude,location: longitude,ofType: sessionType,on: event)
        
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
    var name: String
    var url: String
    let uploadedDate: Date
    let fileType: String
    let fileSize: String
    
    init( _ session: Session , materialId id : Int, materialName name : String,  materialUrl url: String,on uploadedDate:Date, ofFileType fileType:String, ofSize fileSize:String ) {
        
        self.session = session
        self.name = name
        self.url = url
        self.uploadedDate = uploadedDate
        self.fileType = fileType
        self.fileSize = fileSize
    }
    
//    required init(withData: Any?) throws {
//        guard let _  = withData else {
//            return
//        }
//    }
    
    
   }

//MARK: SessionMaterial extension
extension SessionMaterial{
          //add any methods here or computed properties.
}


//MARK: User Session Model
class UserSession {
    
    let person:Person
    let sessId:Int
    
    init(_ person: Person, sessionId sessId: Int) {
        self.person = person
        self.sessId = sessId
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
    let prsId: String
    let userType: PersonType
    let mailId: String
    
    init(_ session: Session?, personId prsId: String, personType userType: PersonType, emailId mailId: String) {
        
        self.session = session
        self.prsId = prsId
        self.userType = userType
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
    
    let person: Person?
    var session: Session?
    let reqId: Int?
    var group: Group
    let requestorId:String
    let requestType: RequestType
    
    init(requestId reqId: Int?,_ person: Person,_ session: Session,_ group:Group,ofRequestType requestType: RequestType) {
        
        self.reqId = reqId
        self.person = person
        self.session = session
        self.group = group
        self.requestorId = person.prsId
        self.requestType = requestType
        
    }
    
    convenience init(_ person: Person,_ session: Session,_ group:Group,ofRequestType requestType: RequestType) {
        
        self.init(requestId: nil,person,session,group,ofRequestType: requestType)
        
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
    
    let actId:Int?
    let actTime:String
    var activity:Activity
    let session: Session
    let requestor: Person
    let receiver: Person
    
    init(activityId actId: Int?,activityTime actTime: String, perfrom activity: Activity, in session: Session, _ requestor: Person, _ receiver : Person) {
        
        self.actId = actId
        self.actTime = actTime
        self.activity = activity
        self.session = session
        self.requestor = requestor
        self.receiver = receiver
        
    }
    
    convenience init(activityTime actTime: String, perfrom activity: Activity, in session : Session, _ requestor: Person,_ receiver: Person) {
        
        self.init(activityId: nil,activityTime:actTime,perfrom:activity,in:session,requestor,receiver)
        
        
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







