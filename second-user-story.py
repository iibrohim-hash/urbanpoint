from common import cur, conn, print_cmd, show_table, c

us2 = '''
* Simple Operational

   As a:  Customer
 I want:  To browse brands by category
So That:  I can easily discover businesses matching my interests
'''

print(us2)

def show_brands_by_category_simple(category_id):
    cols = 'b.BrandID b.Name b.Description'
    print(f"\n Browsing Brands for Category ID: {category_id}")
 
    tmpl = f'''
        SELECT {c(cols)}
          FROM brand AS b
         WHERE b.CategoryID = %s
         ORDER BY b.Name ASC
    '''

    cmd = cur.mogrify(tmpl, (category_id,))
    print_cmd(cmd)
    
    cur.execute(cmd)
    rows = cur.fetchall()
    
    if rows:
        show_table(rows, cols)
    else:
        print(f"No brands found for Category ID {category_id}")

# Test Data 
show_brands_by_category_simple(1)  # Example CategoryID
