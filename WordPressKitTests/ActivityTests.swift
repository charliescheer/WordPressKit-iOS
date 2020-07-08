import XCTest
@testable import WordPressKit

class ActivityTest: XCTestCase {
    func testConvertingActivityObject() {
        let activityObject = MockActivityProvider.getActivityDictionary() as [String : AnyObject]
        
        do {
            XCTAssertNoThrow(try Activity(dictionary: activityObject))
            let _ = try Activity(dictionary: activityObject)
        } catch {
            XCTFail("Could not convert Activity")
        }
    }
    
    func testInitializingActivityFailsNoID() {
        let activityObject = MockActivityProvider.getActivityDictionary(withOption: .missingActivityID) as [String : AnyObject]
        
        do {
            XCTAssertThrowsError(try Activity(dictionary: activityObject))
            let _ = try Activity(dictionary: activityObject)
        } catch {
            let expected = Activity.Error.missingActivityId as NSError
            XCTAssertEqual(error as NSError, expected)
        }
    }
    
    func testInitializingActivityFailsNoSummary() {
        let activityObject = MockActivityProvider.getActivityDictionary(withOption: .missingSummary) as [String : AnyObject]
        
        do {
            XCTAssertThrowsError(try Activity(dictionary: activityObject))
            let _ = try Activity(dictionary: activityObject)
        } catch {
            let expected = Activity.Error.missingSummary as NSError
            XCTAssertEqual(error as NSError, expected)
        }
    }
    
    func testInitializingActivityFailsNoContentText() {
        let activityObject = MockActivityProvider.getActivityDictionary(withOption: .missingContentText) as [String : AnyObject]
        
        do {
            XCTAssertThrowsError(try Activity(dictionary: activityObject))
            let _ = try Activity(dictionary: activityObject)
        } catch {
            let expected = Activity.Error.missingContentText as NSError
            XCTAssertEqual(error as NSError, expected)
        }
    }
    
    func testInitializingActivityFailsNoDate() {
        let activityObject = MockActivityProvider.getActivityDictionary(withOption: .missingPublishDate) as [String : AnyObject]
        
        do {
            XCTAssertThrowsError(try Activity(dictionary: activityObject))
            let _ = try Activity(dictionary: activityObject)
        } catch {
            let expected = Activity.Error.missingPublishedDate as NSError
            XCTAssertEqual(error as NSError, expected)
        }
    }
    
    func testInitializingActivityFailsDateMalformed() {
        let activityObject = MockActivityProvider.getActivityDictionary(withOption: .publishDateIncorrectFormat) as [String : AnyObject]
        
        do {
            XCTAssertThrowsError(try Activity(dictionary: activityObject))
            let _ = try Activity(dictionary: activityObject)
        } catch {
            let expected = Activity.Error.incorrectPusblishedDateFormat as NSError
            XCTAssertEqual(error as NSError, expected)
        }
    }
}

struct MockActivityProvider {
    static func getActivityDictionary(withOption option: ActivityProviderOptions? = nil) -> [String : Any] {
        var activityObject: [String : Any] = [
            "summary" : "Login Succeeded",
            "content" : ["text" : "activity002 logged in successfully"],
            "name" : "user__login",
            "actor": [
                "type": "Person",
                "name": "activity002",
                "external_user_id": 1,
                "wpcom_user_id": 84973892,
                "icon": [
                    "type": "Image",
                    "url": "https:\\/\\/secure.gravatar.com\\/avatar\\/a78c747ecc4e8d1936e8d33080ae1803?s=96&d=mm&r=g",
                    "width": 96,
                    "height": 96
                ],
                "role": "administrator"
            ],
            "type": "Join",
            "published": "2017-10-24T15:16:38.123+00:00",
            "generator": [
                "jetpack_version": 5.4,
                "blog_id": 135188029
            ],
            "is_rewindable": false,
            "gridicon": "lock",
            "status": "null",
            "activity_id": "AV9O9QdZjEqjFGbxaO_m",
            "object": [
                "type": "Person",
                "name": "activity002",
                "external_user_id": 1,
                "wpcom_user_id": 84973892
            ]
        ]
        
        if let option = option {
            switch option {
            case .missingActivityID:
                activityObject.removeValue(forKey: "activity_id")
            case .missingSummary:
                activityObject.removeValue(forKey: "summary")
            case .missingContentText:
                activityObject.removeValue(forKey: "content")
            case .missingPublishDate:
                activityObject.removeValue(forKey: "published")
            case .publishDateIncorrectFormat:
                activityObject["published"] = "2017-10-24T15:16:38"
            }
        }
        return activityObject
    }
}

enum ActivityProviderOptions {
    case missingActivityID
    case missingSummary
    case missingContentText
    case missingPublishDate
    case publishDateIncorrectFormat
}
