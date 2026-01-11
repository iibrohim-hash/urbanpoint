from common import cur, conn, print_cmd, show_table, c
from prettytable import PrettyTable

us10 = '''
* Simple Analytical (Window Function)

   As a:  Customer
 I want:  To see the maximum number of redemptions I made in a single day
So That:  I can understand when I was most active on the app
'''


print(us10)

def max_redemptions_per_day(user_id):
    print(f"\nMax redemptions per day for User {user_id}")

    cols = 'sub.Rank sub.RedemptionDate sub.DailyCount sub.MaxPerDay'

    tmpl = '''
        SELECT 
            ROW_NUMBER() OVER (ORDER BY DailyCount DESC) AS Rank,
            RedemptionDay,
            DailyCount,
            MAX(DailyCount) OVER () AS MaxPerDay
        FROM (
            SELECT DATE(RedemptionDate) AS RedemptionDay,
                   COUNT(*) AS DailyCount
            FROM redemption
            WHERE UserID = %s
            GROUP BY DATE(RedemptionDate)
        ) AS sub
        ORDER BY sub.DailyCount DESC
    '''

    cmd = cur.mogrify(tmpl, (user_id,))
    print_cmd(cmd)

    cur.execute(cmd)
    rows = cur.fetchall()
    show_table(rows, cols)

# Test Data
max_redemptions_per_day(1)