# Employees Submit Expense Claims — PRD

## Problem Statement

Employees spend their own money on travel, meals and supplies and then have to
get it back. Today the claim travels as a paper form or a spreadsheet emailed to
a manager, and an approved claim reaches finance as a scan, a screenshot or a
line in somebody's inbox. The employee cannot see where their money is, managers
approve against incomplete evidence, and finance retypes the same numbers into
payroll — slow, and wrong in ways nobody notices until a payout comes up short.

## Solution

A single web application where an employee files an expense claim as a set of
line items with receipts attached, their manager approves or rejects it with a
comment, and finance sees everything approved in one place and exports it to
payroll.

## Actors

- **Employee** — files expense claims for their own spending, attaches receipts,
and follows each claim's status. A Manager is also an Employee for their own
claims.
- **Manager** — sees the claims submitted by the employees who report to them,
reviews the line items and receipts, and approves or rejects each claim with a
comment.
- **Finance** — sees all approved claims and exports a period's worth to hand to
payroll.

## User Stories

1. As an Employee, I want to sign in with my existing work account, so that I
don't have to keep another password.
2. As an Employee, I want to file a claim as several line items — an amount,
a date, a category and a receipt on each — so that a whole trip goes in as one
submission.
3. As an Employee, I want to see my claims and where each one stands, so that
I know what is still awaiting approval and what has been approved.
4. As an Employee, I want to withdraw a claim I have submitted but that has not
been decided yet, so that I can fix a mistake before it is approved.
5. As an Employee, I want to correct and resubmit a claim my manager rejected, so
that I don't have to start it again from nothing.
6. As a Manager, I want to see the claims my team has submitted, so that I can
review them in one place.
7. As a Manager, I want each line item with its receipt in front of me, so that
I can judge the claim before deciding on it.
8. As a Manager, I want to approve or reject a claim with a comment, so that the
employee knows the outcome and, when it is rejected, why.
9. As Finance, I want to see all approved claims and what they total, so that I
know what is waiting to reach payroll.
10. As Finance, I want to export the approved claims for a date range, so that
payroll can pay them.

## Product Decisions

- **Sign-in** — every user signs in with SSO through the platform identity
provider; the product issues no passwords of its own. (Organization default.)
- **Claim shape** — a claim carries one or more line items, each with an amount,
a date, an expense category and a receipt (an image or a PDF).
- **Approval** — one step: the employee's manager approves or rejects. A
rejection returns the claim to the employee, who can correct and resubmit it.
- **Visibility** — an Employee sees only their own claims, a Manager only the
claims of the employees reporting to them, and Finance every approved claim.
- **Payroll hand-off** — finance downloads the approved claims for a chosen
period as a file; the product does not talk to a payroll system directly.
- **No double payout** — a claim included in an export is marked as exported and
does not appear in a later export.
- **Notifications** — a claim's status is visible in the product; nothing is
emailed in this version.
- **Categories** — a fixed list of expense categories ships with the product;
there is no administration of that list in this version.
- **Currency** — every amount is in the company's single currency; no currency
conversion.

## Out of Scope

- Paying anyone: the product records approval and hands payroll a list; it moves
no money itself.
- A direct payroll system integration — the export is a downloaded file.
- Corporate card feeds, receipt scanning or OCR, and per-diem or spend-limit
policy enforcement.
- Multiple currencies and currency conversion.
- Mobile applications.
- Self-service administration of categories, approval thresholds, or who reports
to whom.
- Email or chat notifications.

## Open Questions

1. What file format and column layout does the payroll process expect for the
export?
2. How does the product know which manager an employee reports to — is the
reporting line held in an HR system, or must it be maintained in this
application?

