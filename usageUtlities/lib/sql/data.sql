Select /*+ Parallel (T1,16) */
             To_Char (Trunc (T1.Sys_Creation_Date), 'Yyyymmdd') "Date",
              Count (*)                   "Records",
              Sum (T1.L3_Volume)          "Volume",
              T1.L9_Volume_Type           "Volume Type",
              T1.Event_Type_Id            "Event Type",
              T1.L3_Payment_Category      "Payment Category",
              T1.L9_Nt_Roaming_Ind        "Roaming Indicator",
              T1.L9_Ip_Address            "Ip Address"
         From Ape1_Rated_Event T1
        Where     Trunc (T1.Sys_Creation_Date) Between Trunc (Sysdate - 90)
                                                   And Trunc (Sysdate - 1)
              And Event_Type_Id In (51, 69) 
              AND t1.l3_payment_category IN ('PRE', 'POST')
              AND t1.l9_volume_type IN ('2G', '3G', '4G')
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
