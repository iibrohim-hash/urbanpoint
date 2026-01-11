from common import cur, conn, print_cmd, show_table, c


us5 = '''
* Simple Operational

   As a:  Brand Admin
 I want:  To add a new outlet branch
So That:  Customers can find our physical locations
'''

print(us5)

def add_new_outlet(brand_id, name, address, city, phone):
    
    print(f"\n Adding New Outlet: {name}")

    cur.execute("SELECT MAX(OutletID) FROM outlet")
    max_id = cur.fetchone()[0]
    if max_id is None:
        new_id = 1
    else:
        new_id = max_id + 1
    
    tmpl = '''
        INSERT INTO outlet (OutletID, BrandID, Name, LocationAddress, City, Country, PhoneNumber, Status)
        VALUES (%s, %s, %s, %s, %s, 'Qatar', %s, 'active')
    '''

    cur.execute(tmpl, (new_id, brand_id, name, address, city, phone))
    conn.commit()
    print(f"Success: Added '{name}' with OutletID {new_id} to Brand {brand_id}.")
    
    check_cols = 'o.OutletID o.Name o.City o.Status'
    check_sql = f"SELECT {c(check_cols)} FROM outlet AS o WHERE o.OutletID = %s"
    cur.execute(check_sql, (new_id,))
    show_table(cur.fetchall(), check_cols)

        

# Test Data 
add_new_outlet(3, 'Fresh food', 'Arrayan ', 'Doha', '123546')