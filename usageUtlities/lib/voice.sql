   SELECT /*+ Parallel (T1,16) */
        TO_CHAR (TRUNC (T1.Sys_Creation_Date), 'Yyyymmdd')"Date",
         COUNT (*)                                        "Records",
         ROUND (SUM (T1.L3_Duration), 8)                  "Minutes Of Use",
         T1.Event_Type_Id                                 "Event Type",
         T1.L3_Payment_Category                           "Payment Category",
         T1.L3_call_category                              "Call Category",
         T1.L9_Nt_Roaming_Ind                             "Roaming Indicator",
         trim(T1.l9_source_system)                        "Switch",
         T1.L9_system_service                             "System Service"
    FROM Ape1_Rated_Event T1
   WHERE     TRUNC (T1.Sys_Creation_Date) BETWEEN TRUNC (SYSDATE - 90)
                                              AND TRUNC (SYSDATE - 1)
         AND Event_Type_Id = 62
GROUP BY TO_CHAR (TRUNC (T1.Sys_Creation_Date), 'Yyyymmdd'),
         T1.L9_Volume_Type,
         T1.Event_Type_Id,
         T1.L3_Payment_Category,
         T1.L3_call_category,
         T1.L9_Nt_Roaming_Ind,
         trim(T1.l9_source_system),
         T1.L9_system_service
ORDER BY TO_CHAR (TRUNC (T1.Sys_Creation_Date), 'Yyyymmdd'),
         T1.L9_Volume_Type,
         T1.Event_Type_Id,
         T1.L3_Payment_Category,
         T1.L3_call_category,
         T1.L9_Nt_Roaming_Ind,
         trim(T1.l9_source_system) ASC
