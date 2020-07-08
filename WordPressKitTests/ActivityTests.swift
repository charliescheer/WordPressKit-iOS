import XCTest
@testable import WordPressKit

class ActivityTest: XCTestCase {
    func testConvertingActivityObject() {
        let activityObject = MockActivityProvider.activityObject as [String : AnyObject]
        
        do {
            XCTAssertNoThrow(try Activity(dictionary: activityObject))
            let activity = try Activity(dictionary: activityObject)
        } catch {
            XCTFail("Could not convert Activity")
        }
    }
}

struct MockActivityProvider {
    static let activityObject: [String : Any] = [
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
}
