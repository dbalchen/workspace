Select /*+ Parallel (T1,16) */
             To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd') "Date",
              Count (*)                   "Records",
              Round (Sum (T1.L3_Volume), 8) "Volume",
              T1.L9_Volume_Type           "Volume Type",
              T1.Event_Type_Id            "Event Type",
              T1.L3_Payment_Category      "Payment Category",
              T1.L9_Nt_Roaming_Ind        "Roaming Indicator",
              T1.L9_Ip_Address            "Ip Address"
         From Ape1_Rated_Event T1
        Where     Trunc (T1.Sys_Creation_Date) Between Trunc (Sysdate - 90)
                                                   And Trunc (Sysdate - 1)
              And Event_Type_Id In (51, 69, 69)
     Group By To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd'),
              T1.L9_Volume_Type,
              T1.Event_Type_Id,
              T1.L3_Payment_Category,
              T1.L9_Nt_Roaming_Ind,
              T1.L9_Ip_Address
     Order By To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd'),
              T1.L9_Volume_Type,
              T1.Event_Type_Id,
              T1.L3_Payment_Category,
              T1.L9_Nt_Roaming_Ind,
              T1.L9_Ip_Address Asc
