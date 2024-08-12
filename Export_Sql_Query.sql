-- Export All Technologies from Account Master
-- 
Select
    "technology"
from
    "Accounts"
where
    "technology" <> '{"null"}'
limit
    10
    -- Not Verfied Account Master data for 50+ employees...
    -- 
Select
    "a"."id" as "Account_id",
    "a"."domain" as "Account_domain",
    "a"."name" as "Account_name",
    "a"."parentAccountName" as "Account_parentAccountName",
    "a"."website" as "Account_website",
    "a"."type" as "Account_type",
    "a"."aliasName" as "Account_aliasName",
    "a"."scrubbedAliasName" as "Account_scrubbedAliasName",
    "a"."email" as "Account_email",
    "a"."industry" as "Account_industry",
    "a"."subIndustry" as "Account_subIndustry",
    "a"."sicCode" as "Account_sicCode",
    "a"."sicDescription" as "Account_sicDescription",
    "a"."naicsCode" as "Account_naicsCode",
    "a"."naicsDescription" as "Account_naicsDescription",
    "a"."employeeRange" as "Account_employeeRange",
    "a"."employeeSize" as "Account_employeeSize",
    "a"."employeeSizeLI" as "Account_employeeSizeLI",
    "a"."employeeSizeZPlus" as "Account_employeeSizeZPlus",
    "a"."employeeSizeOthers" as "Account_employeeSizeOthers",
    "a"."revenue" as "Account_revenue",
    "a"."revenueRange" as "Account_revenueRange",
    "a"."totalFunding" as "Account_totalFunding",
    "a"."latestFundingAmount" as "Account_latestFundingAmount",
    "a"."itSpend" as "Account_itSpend",
    "a"."liUrl" as "Account_liUrl",
    "a"."description" as "Account_description",
    "a"."duns" as "Account_duns",
    "a"."technology" as "Account_technology",
    "a"."tags" as "Account_tags",
    "a"."state" as "Account_state",
    "a"."zipCode" as "Account_zipCode",
    "a"."country" as "Account_country",
    "a"."disposition" as "Account_disposition",
    "a"."comments" as "Account_comments",
    "a"."requestedBy" as "Account_requestedBy",
    "a"."foundedYear" as "Account_foundedYear",
    "a"."lastRaisedAt" as "Account_lastRaisedAt",
    "a"."seoDescription" as "Account_seoDescription",
    "a"."keywords" as "Account_keywords",
    "a"."isVerified" as "Account_isVerified",
    "a"."createdAt" as "Account_createdAt",
    "a"."updatedAt" as "Account_updatedAt",
    "a"."createdBy" as "Account_createdBy",
    "a"."updatedBy" as "Account_updatedBy",
    "a"."ParentAccountDomain" as "Account_ParentAccountDomain",
    "a"."typeDescriptive" as "Account_typeDescriptive",
    "a"."productAndService" as "Account_productAndService",
    "l"."id" as "Location_id",
    "l"."type" as "Location_type",
    "l"."address1" as "Location_address1",
    "l"."address2" as "Location_address2",
    "l"."city" as "Location_city",
    "l"."state" as "Location_state",
    "l"."stateAbbreviation" as "Location_stateAbbreviation",
    "l"."zipCode" as "Location_zipCode",
    "l"."country" as "Location_country",
    "l"."timeZone" as "Location_timeZone",
    "l"."phone1" as "Location_phone1",
    "l"."phone2" as "Location_phone2",
    "l"."addressDedupeKey" as "Location_addressDedupeKey",
    "l"."region" as "Location_region",
    "l"."createdAt" as "Location_createdAt",
    "l"."updatedAt" as "Location_updatedAt",
    "l"."AccountDomain" as "Location_AccountDomain",
    "l"."createdBy" as "Location_createdBy",
    "l"."updatedBy" as "Location_updatedBy"
from
    "Accounts" as "a"
    inner join "Locations" as "l" on "a"."domain" = "l"."AccountDomain"
    and "a"."employeeRange" not in ('0 - 10', '11 - 50')
    and "a"."isVerified" = 'true';

-- 
-- 
-- Export all Account and Locations
-- 
SELECT DISTINCT
    ON ("Account"."name") "Account"."name",
    "Account"."id",
    "Account"."domain",
    "Account"."parentAccountName",
    "Account"."website",
    "Account"."type",
    "Account"."typeDescriptive",
    "Account"."aliasName",
    "Account"."scrubbedAliasName",
    "Account"."email",
    "Account"."industry",
    "Account"."subIndustry",
    "Account"."sicCode",
    "Account"."sicDescription",
    "Account"."naicsCode",
    "Account"."naicsDescription",
    "Account"."employeeRange",
    "Account"."employeeSize",
    "Account"."employeeSizeLI",
    "Account"."employeeSizeZPlus",
    "Account"."employeeSizeOthers",
    "Account"."revenue",
    "Account"."revenueRange",
    "Account"."totalFunding",
    "Account"."latestFundingAmount",
    "Account"."itSpend",
    "Account"."liUrl",
    "Account"."description",
    "Account"."duns",
    "Account"."technology",
    "Account"."productAndService",
    "Account"."tags",
    "Account"."state",
    "Account"."zipCode",
    "Account"."country",
    "Account"."disposition",
    "Account"."comments",
    "Account"."requestedBy",
    "Account"."foundedYear",
    "Account"."lastRaisedAt",
    "Account"."lastFundingType",
    "Account"."noOfRetailLocations",
    "Account"."seoDescription",
    "Account"."keywords",
    "Account"."isVerified",
    "Account"."uploadedFileIds",
    "Account"."previousName",
    "Account"."previousWebsite",
    "Account"."previousType",
    "Account"."previousIndustry",
    "Account"."previousSubIndustry",
    "Account"."previousEmployeeSize",
    "Account"."previousRevenue",
    "Account"."previousTechnology",
    "Account"."createdAt",
    "Account"."updatedAt",
    "Account"."createdBy",
    "Account"."updatedBy",
    "Account"."ParentAccountDomain",
    "Locations"."id" AS "Locations.id",
    "Locations"."type" AS "Locations.type",
    "Locations"."address1" AS "Locations.address1",
    "Locations"."address2" AS "Locations.address2",
    "Locations"."city" AS "Locations.city",
    "Locations"."state" AS "Locations.state",
    "Locations"."stateAbbreviation" AS "Locations.stateAbbreviation",
    "Locations"."zipCode" AS "Locations.zipCode",
    "Locations"."country" AS "Locations.country",
    "Locations"."timeZone" AS "Locations.timeZone",
    "Locations"."phone1" AS "Locations.phone1",
    "Locations"."phone2" AS "Locations.phone2",
    "Locations"."addressDedupeKey" AS "Locations.addressDedupeKey",
    "Locations"."region" AS "Locations.region",
    "Locations"."createdAt" AS "Locations.createdAt",
    "Locations"."updatedAt" AS "Locations.updatedAt",
    "Locations"."AccountDomain" AS "Locations.AccountDomain",
    "Locations"."createdBy" AS "Locations.createdBy",
    "Locations"."updatedBy" AS "Locations.updatedBy"
FROM
    "Accounts" AS "Account"
    INNER JOIN "Locations" AS "Locations" ON "Account"."domain" = "Locations"."AccountDomain"
    AND "Account"."disposition" = 'Active Account'
    AND "Account"."industry" IN ('business services')
    AND "Account"."subIndustry" IN ('custom software & it services');

-- 
-- 
-- All GoldMine Contacts Export with Account and Client Details for Vonage Client
-- 
--
Select
    "cl"."id" as "Client_Id",
    "cl"."name" as "Client_Name",
    "cl"."pseudonym" as "Client_Pseudonym",
    acc.*,
    con.*
from
    (
        Select DISTINCT
            ON (contact_email) contact_email as "con_dis_email",
            "co".*
        from
            (
                Select
                    "c"."id" as "Contact_id",
                    "c"."researchStatus" as "Contact_researchStatus",
                    "c"."callingStatus" as "Contact_callingStatus",
                    "c"."complianceStatus" as "Contact_complianceStatus",
                    "c"."prefix" as "Contact_prefix",
                    "c"."firstName" as "Contact_firstName",
                    "c"."middleName" as "Contact_middleName",
                    "c"."lastName" as "Contact_lastName",
                    con_addr.*,
                    "c"."email" as "contact_email",
                    "c"."genericEmail" as "Contact_genericEmail",
                    "c"."phone" as "Contact_phone",
                    "c"."directPhone" as "Contact_directPhone",
                    "c"."jobTitle" as "Contact_jobTitle",
                    "c"."jobLevel" as "Contact_jobLevel",
                    "c"."jobDepartment" as "Contact_jobDepartment",
                    "c"."nsId" as "Contact_nsId",
                    "c"."zoomInfoContactId" as "Contact_zoomInfoContactId",
                    "c"."linkedInUrl" as "Contact_linkedInUrl",
                    "c"."screenshot" as "Contact_screenshot",
                    "c"."handles" as "Contact_handles",
                    "c"."website" as "Contact_website",
                    "c"."comments" as "Contact_comments",
                    "c"."source" as "Contact_source",
                    "c"."stage" as "Contact_stage",
                    "c"."functions" as "Contact_functions",
                    "c"."disposition" as "Contact_disposition",
                    "c"."zb" as "Contact_zb",
                    "c"."gmailStatus" as "Contact_gmailStatus",
                    "c"."mailTesterStatus" as "Contact_mailTesterStatus",
                    "c"."createdAt" as "Contact_createdAt",
                    "c"."updatedAt" as "Contact_updatedAt",
                    "c"."AccountId" as "Contact_AccountId",
                    "c"."createdBy" as "Contact_createdBy",
                    "c"."updatedBy" as "Contact_updatedBy",
                    "c"."emailDedupeKey" as "Contact_emailDedupeKey",
                    "c"."phoneDedupeKey" as "Contact_phoneDedupeKey",
                    "c"."companyDedupeKey" as "Contact_companyDedupeKey",
                    "c"."label" as "Contact_label",
                    "c"."gmailStatusDateAndTime" as "Contact_gmailStatusDateAndTime",
                    "c"."zbDateAndTime" as "Contact_zbDateAndTime",
                    "c"."phoneExtension" as "Contact_phoneExtension",
                    "c"."duplicateOf" as "Contact_duplicateOf",
                    "c"."complianceComments" as "Contact_complianceComments",
                    "c"."deliveryStatus" as "Contact_deliveryStatus",
                    "c"."mobile" as "Contact_mobile",
                    "c"."emailNameDedupeKey" as "Contact_emailNameDedupeKey",
                    "c"."emailDomainDedupeKey" as "Contact_emailDomainDedupeKey",
                    "c"."ClientId" as "Contact_ClientId",
                    "c"."ProjectId" as "Contact_ProjectId",
                    "c"."mobileNumber1" as "Contact_mobileNumber1",
                    "c"."mobileNumber2" as "Contact_mobileNumber2",
                    "c"."homeNumber" as "Contact_homeNumber",
                    "c"."homeAddressStreet1" as "Contact_homeAddressStreet1",
                    "c"."homeAddressStreet2" as "Contact_homeAddressStreet2",
                    "c"."homeAddressCity" as "Contact_homeAddressCity",
                    "c"."homeAddressState" as "Contact_homeAddressState",
                    "c"."homeAddressZipCode" as "Contact_homeAddressZipCode",
                    "c"."homeAddressCountry" as "Contact_homeAddressCountry"
                from
                    "Contacts" as "c",
                    json_to_record ("address") AS con_addr (
                        "street1" TEXT,
                        "street2" TEXT,
                        "city" TEXT,
                        "state" TEXT,
                        "country" TEXT,
                        "zipCode" TEXT
                    )
                where
                    "c"."researchStatus" in ('Q', 'qa', 'Qa', 'QA', 'QF', 'QR')
                order by
                    "c"."updatedAt" DESC
            ) as "co"
    ) as con
    inner join "Clients" as "cl" on "con"."Contact_ClientId" = "cl"."id"
    and "cl"."id" = 'c5d4644b-4542-4eaa-a6c1-d6e0ad71edfc'
    left outer join (
        Select
            "a"."id" as "Account_id",
            "a"."name" as "Account_name",
            "a"."researchStatus" as "Account_researchStatus",
            "a"."callingStatus" as "Account_callingStatus",
            "a"."complianceStatus" as "Account_complianceStatus",
            "a"."stage" as "Account_stage",
            "a"."zoomInfoName" as "Account_zoomInfoName",
            "a"."domain" as "Account_domain",
            "a"."website" as "Account_website",
            "a"."description" as "Account_description",
            "a"."nsId" as "Account_nsId",
            "a"."zoomInfoContactId" as "Account_zoomInfoContactId",
            "a"."sicCode" as "Account_sicCode",
            "a"."naicsCode" as "Account_naicsCode",
            "a"."sicDescription" as "Account_sicDescription",
            "a"."naicsDescription" as "Account_naicsDescription",
            "a"."source" as "Account_source",
            "a"."employeeSourceLI" as "Account_employeeSourceLI",
            "a"."employeeSourceZ_plus" as "Account_employeeSourceZ_plus",
            "a"."phoneHQ" as "Account_phoneHQ",
            "a"."email" as "Account_email",
            "a"."industry" as "Account_industry",
            "a"."subIndustry" as "Account_subIndustry",
            "a"."locationLI" as "Account_locationLI",
            addr.*,
            "a"."linkedInUrl" as "Account_linkedInUrl",
            "a"."revenue" as "Account_revenue",
            "a"."revenue_M_B_K" as "Account_revenue_M_B_K",
            "a"."employeeSize" as "Account_employeeSize",
            "a"."employeeSizeLI" as "Account_employeeSizeLI",
            "a"."employeeSizeZ_plus" as "Account_employeeSizeZ_plus",
            "a"."employeeSizeFinalBucket" as "Account_employeeSizeFinalBucket",
            "a"."employeeSize_others" as "Account_employeeSize_others",
            "a"."employeeRangeLI" as "Account_employeeRangeLI",
            "a"."disposition" as "Account_disposition",
            "a"."comments" as "Account_comments",
            "a"."upperRevenue" as "Account_upperRevenue",
            "a"."lowerRevenue" as "Account_lowerRevenue",
            "a"."upperEmployeeSize" as "Account_upperEmployeeSize",
            "a"."lowerEmployeeSize" as "Account_lowerEmployeeSize",
            "a"."createdAt" as "Account_createdAt",
            "a"."updatedAt" as "Account_updatedAt",
            "a"."ProjectId" as "Account_ProjectId",
            "a"."createdBy" as "Account_createdBy",
            "a"."updatedBy" as "Account_updatedBy",
            "a"."aliasName" as "Account_aliasName",
            "a"."tokens" as "Account_tokens",
            "a"."scrubbedName" as "Account_scrubbedName",
            "a"."label" as "Account_label",
            "a"."segment_technology" as "Account_segment_technology",
            "a"."emailDomain" as "Account_emailDomain",
            "a"."duplicateOf" as "Account_duplicateOf",
            "a"."complianceComments" as "Account_complianceComments",
            "a"."deliveryStatus" as "Account_deliveryStatus",
            "a"."employeeSize_others_source" as "Account_employeeSize_others_source",
            "a"."qualifiedContacts" as "Account_qualifiedContacts",
            "a"."potential" as "Account_potential",
            "a"."finalDisposition" as "Account_finalDisposition",
            "a"."ClientId" as "Account_ClientId",
            "a"."parentDomain" as "Account_parentDomain",
            "a"."masterDisposition" as "Account_masterDisposition",
            "a"."masterUpdatedAt" as "Account_masterUpdatedAt",
            "a"."type" as "Account_type",
            "a"."masterComments" as "Account_masterComments"
        from
            "Accounts" as "a",
            json_to_record ("addressHQ") as addr (
                "address1HQ" TEXT,
                "address2HQ" TEXT,
                "cityHQ" TEXT,
                "stateHQ" TEXT,
                "countryHQ" TEXT,
                "zipCodeHQ" TEXT
            )
    ) as acc on "con"."Contact_AccountId" = "acc"."Account_id"