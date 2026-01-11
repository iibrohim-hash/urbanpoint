from common import cur, conn, print_cmd, show_table, c


us9 = '''
* Simple Operational

   As a:  System Admin
 I want:  To generate a contact list of all specific geneder users
So That:  I can send them a targeted SMS campaigns.
'''

print(us9)

def get_target_audience_by_gender(gender):
    
    cols = 'u.Name u.MobileNumber u.Gender u.Nationality'
    
    tmpl = f'''
        SELECT {c(cols)}
          FROM app_user AS u
         WHERE u.Gender = %s
    '''

    cmd = cur.mogrify(tmpl, (gender,))
    print_cmd(cmd)
    
    cur.execute(cmd)
    
    # Direct show
    show_table(cur.fetchall(), cols)

# Test Data 
get_target_audience_by_gender('Female')