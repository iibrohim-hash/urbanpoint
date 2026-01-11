from common import cur, conn, print_cmd, show_table, c


us6 = '''
* Complex Operational

   As a:  Brand Admin
 I want:  To view all outlets for my brand with full details
So That:  I can get a full overview of my brand's presence
'''

print(us6)

def show_outlets_for_admin(admin_user_id):

    cols = 'b.Name c.Name o.Name o.City o.Status'

    print(f"\n Fetching Outlets for Admin ID: {admin_user_id} ")

    
    tmpl = f'''
        SELECT b.Name AS BrandName, 
               c.Name AS CategoryName, 
               o.Name AS OutletName, 
               o.City, 
               o.Status
          FROM brand_admin AS ba
          JOIN brand       AS b ON ba.MerchantID  = b.BrandID
          JOIN category    AS c ON b.CategoryID   = c.CategoryID
          JOIN outlet      AS o ON b.BrandID      = o.BrandID
         WHERE ba.UserID = %s
         ORDER BY o.Name ASC
    '''

    cmd = cur.mogrify(tmpl, (admin_user_id,))
    print_cmd(cmd)
    
    cur.execute(cmd)
    rows = cur.fetchall()
    
    show_table(rows, cols)
    

# Test Data

show_outlets_for_admin(6)