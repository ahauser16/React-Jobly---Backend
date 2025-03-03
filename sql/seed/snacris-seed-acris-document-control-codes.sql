-- snacris-seed-acris-document-control.sql

INSERT INTO document_control_codes (record_type, doc_type, doc_type_description, class_code_description, party1_type, party2_type, party3_type)
VALUES
('D', 'AGMT', 'AGREEMENT', 'MORTGAGES & INSTRUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'AMFL', 'AMENDMENT OF FEDERAL LIEN', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'ASPM', 'ASSUMPTION OF MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'ASST', 'ASSIGNMENT, MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'ASSIGNOR/OLD LENDER', 'ASSIGNEE/NEW LENDER', NULL),
('D', 'ASTU', 'UNIT ASSIGNMENT', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'ASUM', 'UCC3 ASSUMPTION', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'BOND', 'BOND', 'OTHER DOCUMENTS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'BRUP', 'UCC3 BANKRUPTCY', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'CERR', 'CERTIFICATE OF REDUCTION', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'CNFL', 'CONTINUATION OF FEDERAL LIEN', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'CERT', 'CERTIFICATE', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'CNTR', 'CONTRACT OF SALE', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'CODP', 'CONDEMNATION PROCEEDINGS', 'DEEDS AND OTHER CONVEYANCES', 'PARTY 1', 'PARTY 2', NULL),
('D', 'CONS', 'CONSENT', 'OTHER DOCUMENTS', 'PARTY 1', NULL, NULL),
('D', 'CONT', 'UCC3 CONTINUATION', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'CTOR', 'COURT ORDER', 'OTHER DOCUMENTS', 'PARTY 1/GRANTOR', 'PARTY 2/GRANTEE', NULL),
('D', 'DCTO', 'COURT ORDER ADVERSE POSS.', 'DEEDS AND OTHER CONVEYANCES', 'PARTY 1', 'PARTY 2', NULL),
('D', 'DECL', 'DECLARATION', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'DEED', 'DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'DEMM', 'DECLARATION OF MODIFI OF MRT', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'DTL', 'DISCHARGE OF TAX LIEN', 'OTHER DOCUMENTS', 'SECURED PARTY', NULL, NULL),
('D', 'EASE', 'EASEMENT', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'FL', 'FEDERAL LIEN-IRS', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'FTL', 'FEDERAL LIEN, OTHER', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'IDED', 'IN REM DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'INIC', 'INITIAL COOP UCC1', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', 'ASSIGNEE'),
('D', 'INIT', 'INITIAL UCC1', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', 'ASSIGNEE'),
('D', 'JUDG', 'JUDGMENT', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'LDMK', 'LANDMARK DESIGNATION', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'LEAS', 'LEASE', 'DEEDS AND OTHER CONVEYANCES', 'LESSOR/LANDLORD', 'LESSEE/TENANT', NULL),
('D', 'LIC', 'LICENSE', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'LTPA', 'LETTERS  PATENT', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'MAPS', 'MAPS', 'OTHER DOCUMENTS', 'PARTY 1', NULL, NULL),
('D', 'MERG', 'MERGER', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'MISC', 'MISCELLANEOUS', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'MMTG', 'MASTER MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGEE/LENDER', NULL, NULL),
('D', 'MTGE', 'MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGOR/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'PAT', 'POWER OF ATTORNEY', 'OTHER DOCUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'PRFL', 'PARTIAL RELEASE OF FED LIEN', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'PSAT', 'PARTIAL SATISFACTION', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'PSGN', 'UCC3 PARTIAL ASSIGNMENT', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'REL', 'RELEASE', 'MORTGAGES & INSTRUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'RFL', 'RELEASE OF FEDERAL LIEN', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'RESO', 'RESOLUTION', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'RFTL', 'RELEASE OF FEDERAL TAX LIEN', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'RLSE', 'UCC3 RELEASE/UCC AMENDMENT', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'RPAT', 'REVOCATION OF POWER OF ATTORNE', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'RTXL', 'RELEASE OF ESTATE TAX LIEN', 'OTHER DOCUMENTS', 'DECEDENT', NULL, NULL),
('D', 'SAGE', 'SUNDRY AGREEMENT', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'SAT', 'SATISFACTION OF MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'SMIS', 'SUNDRY MISCELLANEOUS', 'OTHER DOCUMENTS', 'PARTY 1', NULL, NULL),
('D', 'SMTG', 'SUNDRY MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'STP', 'STREET PROCEDURE', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'SUBL', 'SUBORDINATION OF LEASE', 'DEEDS AND OTHER CONVEYANCES', 'PARTY 1', 'PARTY 2', NULL),
('D', 'SUBO', 'UCC3 SUBORDINATION', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'TLS', 'TAX LIEN SALE CERTIFICATE', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'TERM', 'UCC3 TERMINATION', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'TERT', 'TERMINATION OF TRUST', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'UCC1', 'UNIFORM COMMERCIAL CODE 1', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', 'ASSIGNEE'),
('D', 'UCC3', 'UNIFORM COMMERCIAL CODE 3', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'VAC', 'VACATE ORDER', 'DEEDS AND OTHER CONVEYANCES', 'PARTY 1', NULL, NULL),
('D', 'WILL', 'CERTIFIED COPY OF WILL', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'ASGN', 'UCC3 ASSIGNMENT', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', 'NEW SECURED PARTY'),
('D', 'ASSTO', 'ASSIGNMENT OF LEASE', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'WSAT', 'WITHHELD SATISFACTION', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'RETT', 'NYS REAL ESTATE TRANSFER TAX', 'OTHER DOCUMENTS', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'RPTT', 'NYC REAL PROPERTY TRANSFER TAX', 'OTHER DOCUMENTS', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'CDEC', 'CONDO DECLARATION', 'DEEDS AND OTHER CONVEYANCES', 'PARTY 1', NULL, NULL),
('D', 'AL&R', 'ASSIGNMENT OF LEASES AND RENTS', 'MORTGAGES & INSTRUMENTS', 'ASSIGNOR', 'ASSIGNEE', NULL),
('D', 'DEEDO', 'DEED, OTHER', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR', 'GRANTEE', NULL),
('D', 'AMTX', 'ADDITIONAL MORTGAGE TAX', 'MORTGAGES & INSTRUMENTS', 'PAYER', 'PARTY TWO', NULL),
('D', 'AMND', 'UCC3 AMENDMENT', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'AMTL', 'AMENDMENT OF TAX LIEN', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'ATL', 'ASSIGNMENT OF TAX LIEN', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'RPTT&RET', 'BOTH RPTT AND RETT', 'OTHER DOCUMENTS', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'CORR', 'CORRECTION DOC-OFFICE USE ONLY', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', 'PARTY 3'),
('D', 'CORP', 'UCC 5 CORRECTION STATEMENT', 'UCC AND FEDERAL LIENS', 'PARTY 1', 'PARTY 2', 'PARTY 3'),
('D', 'ZONE', 'ZONING LOT DESCRIPTION', 'OTHER DOCUMENTS', 'PARTY ONE', NULL, NULL),
('D', 'AALR', 'ASGN OF ASGN OF L&R', 'MORTGAGES & INSTRUMENTS', 'ASSIGNOR', 'ASSIGNEE', NULL),
('D', 'CALR', 'CANCEL/TERM ASGN L&R', 'OTHER DOCUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'ADEC', 'AMENDED CONDO DECLARATION', 'OTHER DOCUMENTS', 'PARTY ONE', NULL, NULL),
('D', 'LOCC', 'LIEN OF COMMON CHARGES', 'OTHER DOCUMENTS', 'PARTY ONE/DEBTOR', 'PARTY TWO/SECURED PA', NULL),
('D', 'TOLCC', 'TERM OF LIEN OF COMMON CHARGES', 'OTHER DOCUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'DEVR', 'DEVELOPMENT RIGHTS', 'DEEDS AND OTHER CONVEYANCES', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'DECM', 'DECLARATION OF MERGER', 'DEEDS AND OTHER CONVEYANCES', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'MLEA', 'MEMORANDUM OF LEASE', 'DEEDS AND OTHER CONVEYANCES', 'LESSOR', 'LESSEE', NULL),
('D', 'MCON', 'MEMORANDUM OF CONTRACT', 'DEEDS AND OTHER CONVEYANCES', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'M&CON', 'MORTGAGE AND CONSOLIDATION', 'MORTGAGES & INSTRUMENTS', 'MORTGAGOR', 'MORTGAGEE', NULL),
('D', 'SPRD', 'MORTGAGE SPREADER AGREEMENT', 'MORTGAGES & INSTRUMENTS', 'PARTY ONE/MORTGAGOR', 'PARTY TWO/MORTGAGEE', NULL),
('D', 'TL&R', 'TERMINATION OF ASSIGN OF L&R', 'OTHER DOCUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'SUBM', 'SUBORDINATION OF MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'PREL', 'PARTIAL RELEASE OF MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'ACON', 'ASSIGN/TERM OF CONTRACT/BID', 'DEEDS AND OTHER CONVEYANCES', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'CORRD', 'CORRECTION DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'CORRM', 'CORRECTION MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGOR/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'CONDEED', 'CONFIRMATORY DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'REIT', 'REAL ESTATE INV TRUST DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'TERL', 'TERMINATION OF LEASE OR MEMO', 'OTHER DOCUMENTS', 'LESSOR', 'LESSEE', NULL),
('D', 'ESTL', 'ESTOPPEL FOR OFFICE USE ONLY', 'OTHER DOCUMENTS', 'MORTGAGOR', 'NYC', NULL),
('D', 'XXXX', 'APPRT BREAKDWN OFFICE USE ONLY', 'MORTGAGES & INSTRUMENTS', 'MORTGAGOR', 'MORTGAGEE', NULL),
('D', 'CMTG', 'COLLATERAL MORTGAGE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGOR', 'MORTGAGEE', NULL),
('D', 'WFL', 'WITHDRAWAL OF A FED LIEN', 'UCC AND FEDERAL LIENS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'ESRM', 'ESTOPPAL REMOVAL OFFICE USE ON', 'OTHER DOCUMENTS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'NTXL', 'NOTICE OF  ESTATE TAX LIEN', 'UCC AND FEDERAL LIENS', 'PARTY ONE', 'IRS', NULL),
('D', 'NAPP', 'NOTICE OF APPROPRIATION', 'DEEDS AND OTHER CONVEYANCES', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'TERA', 'TERMINATION OF AGREEMENT', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'RCRFL', 'REVOCATION OF CERTIF. OF RFL', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'DEED COR', 'CORRECT  INDEX/DEED-OFFICE USE', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR', 'GRANTEE', NULL),
('D', 'DEED, LE', 'LIFE ESTATE DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', 'LIFE ESTATE RETAINED'),
('D', 'CORR, LE', 'CORRECT LIFE ESTATE OFFICE USE', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', 'LIFE ESTATE RETAINED'),
('D', 'DEED, TS', 'TIMESHARE DEED', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'UCC ADEN', 'UCC COOPERATIVE ADDENDUM', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'TERDECL', 'TERM. OF CONDO DECLARATION', 'OTHER DOCUMENTS', 'PARTY 1', 'PARTY 2', NULL),
('D', 'NAFTL', 'CERT NONATTCHMENT FED TAX LIEN', 'UCC AND FEDERAL LIENS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'APPRT', 'APP. ORDER BREAKDWN OFFICE USE', 'MORTGAGES & INSTRUMENTS', 'MORTGAGER/BORROWER', 'MORTGAGEE/LENDER', NULL),
('D', 'AIRRIGHT', 'AIR RIGHTS', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'SI CORR', 'SI BILLING UPDATE OFFICE USE', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR', 'GRANTEE', NULL),
('D', 'PWFL', 'PARTIAL WITHDRAWL OF FED LIEN', 'UCC AND FEDERAL LIENS', 'PARTY ONE', 'PARTY TWO', NULL),
('D', 'PRCFL', 'PARTIAL REVOCATION OF CERT RFL', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'DPFTL', 'DISCHARGE OF PROPERTY FROM FTL', 'UCC AND FEDERAL LIENS', 'DEBTOR', 'SECURED PARTY', NULL),
('D', 'DEEDP', 'DEED, PRE RPT TAX', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'TORREN', 'TORREN', 'DEEDS AND OTHER CONVEYANCES', 'PARTY  1', 'PARTY  2', NULL),
('D', 'DEED, RC', 'DEED WITH RESTRICTIVE COVENANT', 'DEEDS AND OTHER CONVEYANCES', 'GRANTOR/SELLER', 'GRANTEE/BUYER', NULL),
('D', 'SCDEC', 'DECLARATION OF CONDO IN CONDO', 'DEEDS AND OTHER CONVEYANCES', 'PARTY 1', NULL, NULL),
('D', 'TODD', 'TRANSFER ON DEATH DEED', 'DEEDS AND OTHER CONVEYANCES', 'TRANSFEROR', 'DESGNTD BENEFICIARY', NULL),
('D', 'RTOD', 'REVOCATION OF TOD DEED', 'DEEDS AND OTHER CONVEYANCES', 'TRANSFEROR', 'DESGNTD BENEFICIARY', NULL);