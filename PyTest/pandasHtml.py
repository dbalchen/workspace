#!/usr/bin/python

import pandas as pd
import numpy as np

pd.set_option('display.width', 1000)
pd.set_option('colheader_justify', 'center')

np.random.seed(6182018)
demo_df = pd.DataFrame({'date': np.random.choice(pd.date_range('2018-01-01', '2018-06-18', freq='D'), 50),
                        'analysis_tool': np.random.choice(['pandas', 'r', 'julia', 'sas', 'stata', 'spss'],50),              
                        'database': np.random.choice(['postgres', 'mysql', 'sqlite', 'oracle', 'sql server', 'db2'],50), 
                        'os': np.random.choice(['windows 10', 'ubuntu', 'mac os', 'android', 'ios', 'windows 7', 'debian'],50), 
                        'num1': np.random.randn(50)*100,
                        'num2': np.random.uniform(0,1,50),                   
                        'num3': np.random.randint(100, size=50),
                        'bool': np.random.choice([True, False], 50)
                       },
                        columns=['date', 'analysis_tool', 'num1', 'database', 'num2', 'os', 'num3', 'bool']
          )


print(demo_df.head(10))

pd.set_option('colheader_justify', 'center')   # FOR TABLE <th>

html_string = '''
<html>
  <head><title>HTML Pandas Dataframe with CSS</title></head>
  <link rel="stylesheet" type="text/css" href="df_style.css"/>
  <body>
    {table}
  </body>
</html>.
'''

# OUTPUT AN HTML FILE
with open('myhtml.html', 'w') as f:
    f.write(html_string.format(table=demo_df.to_html(classes='mystyle')))