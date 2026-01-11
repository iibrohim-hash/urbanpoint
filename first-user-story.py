from common import cur, conn, print_cmd, show_table, c

us1 = '''
* Complex Operational

   As a:  Customer
 I want:  To create an account (Name + Mobile + Email)
So That:  I can start redeeming offers
'''

print(us1)


def register_customer(name, mobile, email, language='English'):
    
    # Auto-generates UserID
    cur.execute("SELECT MAX(UserID) FROM app_user")
    max_id = cur.fetchone()[0]
    
    if max_id is None:
        new_id = 1
    else:
        new_id = max_id + 1
    
    print(f"\n Registering: {name} (ID: {new_id})")

    
    tmpl_user = '''
        INSERT INTO app_user (UserID, Name, MobileNumber, Email, DateJoined, PreferredLanguage) 
        VALUES (%s, %s, %s, %s, CURRENT_DATE, %s) 
    '''
    cur.execute(tmpl_user, (new_id, name, mobile, email, language))

    tmpl_customer = '''
        INSERT INTO customer (UserID, LoyaltyPoints) 
        VALUES (%s, 0)
    '''
    
    cmd = cur.mogrify(tmpl_customer, (new_id,))
    print_cmd(cmd)
    
    cur.execute(cmd)
    conn.commit() # Commit transaction

    verify_cols = 'u.UserID u.Name u.MobileNumber u.Email c.LoyaltyPoints'
    
    verify_tmpl = f'''
        SELECT {c(verify_cols)}
          FROM app_user AS u
          JOIN customer AS c ON u.UserID = c.UserID
         WHERE u.UserID = %s
    '''
    
    cur.execute(verify_tmpl, (new_id,))
    rows = cur.fetchall()
    show_table(rows, verify_cols)

# Test Data 
# Users don't need to assign IDs; they are auto-generated
register_customer('Madina Sister', '+97050099336', 'maemail@qu.edu.qa')