from common import cur, conn, print_cmd, show_table, c

# New Functionality 
us7 = '''
* Complex Analytical (NEW)

   As a:  System Admin 
 I want:  To view a breakdown of total revenue and transaction counts 
          grouped by payment method
So That:  I can identify which transaction channel is the most popular 
          and prioritize gateway maintenance or promotions accordingly.
'''

print(us7)

def analyze_payment_popularity():
    
   
    cols = 'p.PaymentMethod p.Currency p.TotalTransactions p.TotalRevenue'
    
    tmpl = '''
        SELECT 
            PaymentMethod AS PaymentMethod,
            Currency AS Currency,
            COUNT(*) as TotalTransactions,
            SUM(Amount) as TotalRevenue
          FROM payment AS p
         GROUP BY PaymentMethod, Currency
         ORDER BY TotalRevenue DESC
    '''

    
    cmd = cur.mogrify(tmpl)
    print_cmd(cmd)
    
    cur.execute(cmd)
    
    
    show_table(cur.fetchall(), cols)

# --- Test Data ---
analyze_payment_popularity()