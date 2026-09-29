Feature: Signing in

  @story-1
  Rule: Everyone reaches the product through their own work account

    Scenario: An employee signs in with her work account
      Given Amara has no session
      When she opens the product and signs in with her work account
      Then she lands on her own claims

    @negative
    Scenario: Nobody reaches a claim without signing in
      Given a visitor has no session
      When the visitor opens the product
      Then the sign-in page is shown
