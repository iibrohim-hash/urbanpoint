from common import cur, conn, print_cmd, show_table, c

us8 = '''
* Complex Analytical (Window Functions)

   As a:  System Admin
 I want:  To view all outlets ranked by their total number of redemptions
So That:  I can identify the highest-performing outlets across the platform
'''

print(us8)

def show_outlet_redemption_ranking():

    print("\n Calculating Outlet Redemption Rankings ")

    cols = 'OutletName BrandName TotalRedemptions Rank'

    tmpl = '''
        SELECT 
            o.Name AS OutletName,
            b.Name AS BrandName,
            COUNT(r.RedemptionID) AS TotalRedemptions,
            RANK() OVER (ORDER BY COUNT(r.RedemptionID) DESC) AS Rank
        FROM outlet o
        JOIN offer_outlet oo ON o.OutletID = oo.OutletID
        JOIN offer ofr ON oo.OfferID = ofr.OfferID
        LEFT JOIN redemption r ON r.OutletID = o.OutletID
        JOIN brand b ON ofr.BrandID = b.BrandID
        GROUP BY o.Name, b.Name
        ORDER BY TotalRedemptions DESC, OutletName;
    '''

    cmd = cur.mogrify(tmpl)
    print_cmd(cmd)

    cur.execute(cmd)
    rows = cur.fetchall()

    show_table(rows, cols)

# Test
show_outlet_redemption_ranking()
