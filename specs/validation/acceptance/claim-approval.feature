Feature: Claim approval

  @story-6
  Rule: A manager sees the claims submitted by the employees who report to them, and no others

    Scenario: The queue holds a submitted claim from the manager's team
      Given Amara, who shares a directory group with Ravi, has a claim named uniquely for this run awaiting approval
      When Ravi opens his approvals
      Then that claim appears

    @negative
    Scenario: A claim from another team stays out of the queue
      Given Bola, who shares no directory group with Ravi, has a claim named uniquely for this run awaiting approval
      When Ravi opens his approvals
      Then Bola's claim does not appear

  @story-7
  Rule: A manager decides a claim after seeing every line of it and the receipt on each

    Scenario: The manager opens a submitted claim
      Given Amara, who shares a directory group with Ravi, has a claim named uniquely for this run awaiting approval on 2 lines
      When Ravi opens that claim
      Then he sees its 2 lines
      And each line shows its receipt

  @story-8
  Rule: A manager approves or rejects a submitted claim, and a rejection carries a reason

    Scenario: Approving a submitted claim
      Given Amara, who shares a directory group with Ravi, has a claim named uniquely for this run awaiting approval
      When Ravi approves it
      Then its status is "approved"

    Scenario: Rejecting a submitted claim with a reason
      Given Amara, who shares a directory group with Ravi, has a claim named uniquely for this run awaiting approval
      When Ravi rejects it with the comment "the meals line needs an itemised receipt"
      Then its status is "rejected"

    @negative
    Scenario: A rejection with no reason does not stick
      Given Amara, who shares a directory group with Ravi, has a claim named uniquely for this run awaiting approval
      When Ravi rejects it without a comment
      Then its status is "submitted"

    @negative
    Scenario: A claim that was already decided is not decided again
      Given Amara, who shares a directory group with Ravi, has a claim named uniquely for this run, approved by Ravi
      When Ravi rejects it
      Then its status is "approved"
