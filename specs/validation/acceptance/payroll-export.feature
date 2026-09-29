Feature: Payroll export

  @story-9
  Rule: Finance sees every approved claim and what the approved claims total

    Scenario: An approved claim and the running total
      Given Amara has a claim named uniquely for this run, approved by her manager, totalling "412.60"
      When Priya opens the approved claims
      Then that claim is listed as approved
      And the approved total includes "412.60"

    @negative
    Scenario: A claim still awaiting approval is not among the approved
      Given Amara has a claim named uniquely for this run, awaiting approval, totalling "96.20"
      When Priya opens the approved claims
      Then that claim is not listed

  @story-10
  Rule: Finance exports the approved claims of a date range, one row per expense line

    Scenario: The export carries a row for each expense line
      Given Amara has a claim named uniquely for this run, approved by her manager, on 2 lines
      When Priya exports the approved claims from "01 Jan 2020" to "31 Dec 2035"
      Then the downloaded export holds 2 rows for that claim
      And each of those rows carries the employee, the expense date, the category and the amount

  @story-10 @negative
  Rule: A claim already handed to payroll is never exported a second time

    Scenario: A second export leaves out a claim it already sent
      Given Amara has a claim named uniquely for this run, approved by her manager, and already exported to payroll
      When Priya exports the approved claims from "01 Jan 2020" to "31 Dec 2035"
      Then the downloaded export holds no rows for that claim
