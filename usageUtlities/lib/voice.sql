       Select /*+ Parallel (T1,16) */
             To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd') "Date",
              Count (*)                     "Records",
              Round (Sum (T1.L3_Duration), 8) "Minutes Of Use",
              'SMS Text'                     "Volume Type",
              T1.Event_Type_Id              "Event Type",
              T1.L3_Payment_Category        "Payment Category",
              T1.L9_Nt_Roaming_Ind          "Roaming Indicator"
         From Ape1_Rated_Event T1
        Where     Trunc (T1.Sys_Creation_Date) Between Trunc (Sysdate - 90)
                                                   And Trunc (Sysdate - 1)
              And Event_Type_Id = 62
     Group By To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd'),
              T1.L9_Volume_Type,
              T1.Event_Type_Id,
              T1.L3_Payment_Category,
              T1.L9_Nt_Roaming_Ind
     Order By To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd'),
              T1.L9_Volume_Type,
              T1.Event_Type_Id,
              T1.L3_Payment_Category,
              T1.L9_Nt_Roaming_Ind Asc
