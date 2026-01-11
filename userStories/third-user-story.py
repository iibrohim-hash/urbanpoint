from common import cur, conn, print_cmd, show_table, c


us3 = '''
* Simple Operational

   As a:  Customer
 I want:  To view active outlets in a specific city
So That:  I can find open business locations where I plan to visit
'''

print(us3)

def show_outlets_by_city(city_name):

    cols = 'o.OutletID o.Name o.LocationAddress o.City o.PhoneNumber o.Status'

    print(f"\n Browsing Active Outlets in: {city_name} ")
    
    tmpl = f'''
        SELECT {c(cols)}
          FROM outlet AS o
         WHERE o.City ILIKE %s
           AND o.Status = 'active'
         ORDER BY o.Name ASC
    '''

    cmd = cur.mogrify(tmpl, (city_name,))
    print_cmd(cmd)
    
    cur.execute(cmd)
    rows = cur.fetchall()
    
    if rows:
        show_table(rows, cols)
    else:
        print(f"No active outlets found in {city_name}")

# Test Data
show_outlets_by_city('Doha')