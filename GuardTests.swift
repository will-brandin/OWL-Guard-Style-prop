import XCTest

var optionalValue: String?
var otherOptionalValue: String?
var myOtherProperty = 1

@discardableResult
func myFunction() -> String? {
    // Test Case #1
    /// Single Line
    /// Pro: Takes up less real estate.
    /// Con: When debugging, positive and negative cases will both hit debugger
    guard let _ = optionalValue else { return nil }
    
    // Test Case #2
    /// Spaced Single Line
    /// Pro: Can set a breakpoint only on `else` case rather than whole condition
    /// Pro: Behavior becomes the same for `guard` with one line and multiple lines in the `else`
    /// Con: Real estate, ie, 5 guards is 15 lines vs 5
    guard let _ = otherOptionalValue else {
        return nil
    }
    
    // Test Case #3
    /// Multiple conditions, Single line Spaced
    /// Con: Can't set a breakpoint on 2nd condition.
    /// Con: 'Step-Over' skips conditionals and goes to return
    guard let value3 = optionalValue, value3 != "Hello World", myOtherProperty > 0 else {
       return nil
    }
    
    // Test Case #4
    /// Multiple Conditions, line spaced
    /// Pro: Step-Over can debug to next line.
    ///
    /// `else` on it's own line. Optional but improves readability of conditions, imo.
    guard let value4 = optionalValue,
          myOtherProperty > 2,
          value4 != "Bar"
    else {
        return nil
    }
  
    return nil
}

class UITestingTests: XCTestCase {
    
    override func setUp() {
        optionalValue = nil
        otherOptionalValue = nil
    }
    
    override func tearDown() {
        optionalValue = nil
        otherOptionalValue = nil
    }

    // #1
    func test_SingleLine() {
        myFunction()
    }
    // #2
    func test_Spaced_SingleLine() {
        optionalValue = "SUP"
        myFunction()
    }
    // #3
    func test_MultipleConditions_SingleLine() {
        optionalValue = "Hello World"
        otherOptionalValue = "Bar"
        myFunction()
    }
    // #4
    func test_MultipleConditions_ElseSpace() {
        optionalValue = "Foo"
        otherOptionalValue = "Bar"
        myFunction()
    }
}
