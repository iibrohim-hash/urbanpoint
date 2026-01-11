from common import cur, conn, print_cmd, show_table, c

us4 = '''
* Simple Analytical

   As a:  Customer
 I want:  To see how many offers I have saved overall
So That:  I can understand how actively I use the app’s save-for-later feature
'''

print(us4)

def count_saved_offers(user_id):
    print(f"\n Calculating total saved offers for User {user_id} ")

    cols = 's.TotalSavedOffers'

    tmpl = '''
        SELECT COUNT(s.OfferID) AS TotalSavedOffers
          FROM saved_offer AS s
         WHERE s.UserID = %s
    '''

    cmd = cur.mogrify(tmpl, (user_id,))
    print_cmd(cmd)

    cur.execute(cmd)
    rows = cur.fetchall()

    if rows and rows[0][0] > 0:
        show_table(rows, cols)
    else:
        print(f"User ID {user_id} not found or has no saved offers.")

# Test Data 
count_saved_offers(1)
