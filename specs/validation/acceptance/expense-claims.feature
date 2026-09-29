Feature: Expense claims

  @story-2
  Rule: A claim holds one or more expense lines, each with a date, a category and an amount

    Scenario: Filing a claim with two lines
      Given Amara has started a claim named uniquely for this run
      When she adds a line dated "12 Mar" in "Travel" for "240.00"
      And she adds a line dated "13 Mar" in "Meals" for "18.00"
      Then the claim holds exactly 2 lines
      And the claim's total is "258.00"

  @story-2
  Rule: A claim goes for approval only once every one of its lines carries a receipt

    Scenario: A claim whose lines all carry receipts goes for approval
      Given Amara has started a claim named uniquely for this run
      And every line on it carries a receipt
      When she submits it for approval
      Then its status is "submitted"

    @negative
    Scenario: A line with no receipt holds the claim back
      Given Amara has started a claim named uniquely for this run
      And one line on it has no receipt
      When she submits it for approval
      Then its status is "draft"

  @story-3
  Rule: An employee sees their own claims and where each one stands

    Scenario: Amara sees the claim she filed
      Given Amara has a claim named uniquely for this run, awaiting approval
      When she opens her claims
      Then that claim appears with its status and its total

    @negative
    Scenario: One employee cannot see another's claim
      Given Amara has a claim named uniquely for this run, awaiting approval
      And Bola has a work account of their own
      When Bola opens their claims
      Then Amara's claim does not appear

  @story-4
  Rule: Only the employee who filed a claim may withdraw it, and only while it is undecided

    Scenario: Withdrawing a claim that is still awaiting approval
      Given Amara has a claim named uniquely for this run, awaiting approval
      When she withdraws it
      Then its status is "withdrawn"

    @negative
    Scenario: A claim that was already approved cannot be withdrawn
      Given Amara has a claim named uniquely for this run, approved by her manager
      When she withdraws it
      Then its status is "approved"

  @story-5
  Rule: A rejected claim comes back to its employee with the reason, and can be corrected and sent again

    Scenario: Correcting and resubmitting a rejected claim
      Given Amara has a claim named uniquely for this run, rejected by her manager
      When she corrects a line on it and submits it again
      Then its status is "submitted"

    Scenario: The employee can read why it was rejected
      Given Amara has a claim named uniquely for this run, rejected with the comment "the meals line needs an itemised receipt"
      When she opens that claim
      Then she sees the comment "the meals line needs an itemised receipt"
