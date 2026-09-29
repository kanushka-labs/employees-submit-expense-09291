// Expense claims — three roles, seven screens, desktop

screen MyClaims "An employee tracks their own claims and starts a new one"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> ClaimEditor"
  row
    heading "My Claims"
    right
    search "Search claims"
    select "Status: All"
  row
    card "Awaiting approval | 3 | submitted this month"
    card "Approved | 7 | this quarter"
    card "Rejected | 1 | needs a correction"
  table "Reference | Submitted | Items | Total | Status" -> ClaimDetail
    row "CLM-0041 | 12 Mar | 3 | 412.60 | Submitted"
    row "CLM-0039 | 04 Mar | 1 | 18.50 | Approved"
    row "CLM-0036 | 27 Feb | 2 | 96.00 | Rejected"
  row
    right
    button "New claim" primary -> ClaimEditor

screen ClaimEditor "An employee records the lines of a claim and attaches a receipt to each"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> ClaimEditor"
  breadcrumb "My Claims / New claim"
  heading "New Claim"
  text "Lines: 3 - Total 412.60 - Receipts 2 of 3 attached"
  table "Date | Category | Amount | Receipt"
    row "12 Mar | Travel | 240.00 | berlin-air.pdf"
    row "12 Mar | Accommodation | 154.60 | hotel.pdf"
    row "13 Mar | Meals | 18.00 | none attached"
  row
    input "Date — 13 Mar"
    select "Category: Meals"
    input "Amount — 18.00"
    button "Add line"
  row
    input "Receipt file — a PDF or an image"
    button "Attach receipt"
  row
    right
    button "Save draft" -> MyClaims
    button "Submit claim" primary -> ClaimDetail

screen ClaimDetail "An employee reads one claim, withdraws it, or corrects a rejected one"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> ClaimEditor"
  breadcrumb "My Claims / CLM-0041"
  row
    heading "CLM-0041 — Berlin customer visit"
    badge "Rejected" danger
  text "Submitted 12 Mar by A. Okafor - decided 14 Mar by R. Mensah"
  split 60/40
    left
      heading "Expense lines"
      table "Date | Category | Amount | Receipt"
        row "12 Mar | Travel | 240.00 | berlin-air.pdf"
        row "12 Mar | Accommodation | 154.60 | hotel.pdf"
        row "13 Mar | Meals | 18.00 | receipt.jpg"
      row
        right
        button "Withdraw claim" danger
        button "Edit and resubmit" primary -> ClaimEditor
    right
      card "Your manager's decision"
        text "R. Mensah - 14 Mar: the meals line needs an itemised receipt."
      heading "History"
      text "14 Mar — R. Mensah rejected this claim"
      text "12 Mar — A. Okafor submitted it for approval"

screen Approvals "A manager reviews the claims their team has submitted"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | Approvals -> Approvals"
  row
    heading "Approvals"
    right
    search "Search by employee"
    select "Status: Submitted"
  row
    card "Awaiting your decision | 4 | from your team"
    card "Total waiting | 1,284.90 | across those claims"
  table "Employee | Reference | Submitted | Items | Total | Status" -> ClaimReview
    row "A. Okafor | CLM-0041 | 12 Mar | 3 | 412.60 | Submitted"
    row "J. Silva | CLM-0042 | 13 Mar | 2 | 96.20 | Submitted"
    row "M. Haddad | CLM-0043 | 13 Mar | 1 | 776.10 | Submitted"

screen ClaimReview "A manager inspects a claim's lines and receipts, then approves or rejects it"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | Approvals -> Approvals"
  breadcrumb "Approvals / CLM-0041"
  row
    heading "CLM-0041 — A. Okafor"
    badge "Submitted" info
  text "Submitted 12 Mar - 3 lines - total 412.60"
  split 60/40
    left
      heading "Expense lines"
      table "Date | Category | Amount | Receipt"
        row "12 Mar | Travel | 240.00 | berlin-air.pdf"
        row "12 Mar | Accommodation | 154.60 | hotel.pdf"
        row "13 Mar | Meals | 18.00 | receipt.jpg"
    right
      card "Your decision"
        textarea "Why are you rejecting this claim?"
        row
          button "Reject" danger -> Approvals
          button "Approve" primary -> Approvals

screen ApprovedClaims "Finance sees every approved claim and what it totals"
  navbar "Expense Claims"
  sidebar "Approved Claims -> ApprovedClaims | Export -> ExportClaims"
  row
    heading "Approved claims"
    right
    select "Period: This month"
  row
    card "Approved claims | 18 | in this period"
    card "Total to pay | 4,318.40 | not yet exported"
    card "Already exported | 6 | in earlier runs"
  row
    heading "Waiting for payroll"
    right
    button "Export to payroll" primary -> ExportClaims
  table "Employee | Reference | Approved | Items | Total | Exported"
    row "A. Okafor | CLM-0039 | 05 Mar | 1 | 18.50 | No"
    row "J. Silva | CLM-0038 | 04 Mar | 4 | 512.00 | No"
    row "M. Haddad | CLM-0035 | 01 Mar | 2 | 210.75 | Yes"

screen ExportClaims "Finance picks a date range and downloads the CSV payroll imports"
  navbar "Expense Claims"
  sidebar "Approved Claims -> ApprovedClaims | Export -> ExportClaims"
  breadcrumb "Approved claims / Export to payroll"
  heading "Export to payroll"
  row
    input "From — 01 Mar"
    input "To — 31 Mar"
    button "Preview"
  row
    card "Claims in this export | 12 | approved in the period"
    card "Expense lines | 31 | one CSV row each"
    card "Total | 2,486.10 | payable to 9 employees"
  table "Employee | Reference | Approved | Lines | Total"
    row "A. Okafor | CLM-0039 | 05 Mar | 1 | 18.50"
    row "J. Silva | CLM-0038 | 04 Mar | 4 | 512.00"
  row
    right
    button "Back to approved claims" -> ApprovedClaims
    button "Export to CSV" primary  // in place — marks the claims exported and downloads the file

flow "File a claim"
  role "Employee"
  description "An employee files a claim, attaches receipts and follows it to a decision"
  MyClaims
  ClaimEditor
  ClaimDetail

flow "Approve a claim"
  role "Manager"
  description "A manager reviews the claims their team submitted and decides each one"
  Approvals
  ClaimReview

flow "Export to payroll"
  role "PayrollExporter"
  description "Finance exports a period's approved claims for payroll"
  ApprovedClaims
  ExportClaims
