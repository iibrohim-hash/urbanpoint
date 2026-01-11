import sys

menu = '''
UrbanPoint User Stories Menu
---------------------------
1. Register Customer (first-user-story.py)
2. Show Brands by Category (second-user-story.py)
3. Show Outlets by City (third-user-story.py)
4. Count Saved Offers (fourth-user-story.py)
5. Add New Outlet (fifth-user-story.py)
6. Show Outlets for Admin (sixth-user-story.py)
7. Analyze Payment Popularity (seventh-user-story.py)
8. Show Category Growth (eighth-user-story.py)
9. Get Target Audience by Gender (ninth-user-story.py)
10. Max Redemptions Per Day (tenth-user-story.py)
0. Exit
'''

scripts = [
    'first-user-story.py',
    'second-user-story.py',
    'third-user-story.py',
    'fourth-user-story.py',
    'fifth-user-story.py',
    'sixth-user-story.py',
    'seventh-user-story.py',
    'eighth-user-story.py',
    'ninth-user-story.py',
    'tenth-user-story.py',
]

def main():
    while True:
        print(menu)
        try:
            choice = int(input('Select an option (0-10): '))
        except ValueError:
            print('Invalid input. Please enter a number from 0 to 10.')
            continue
        if choice == 0:
            print('Goodbye!')
            sys.exit(0)
        elif 1 <= choice <= 10:
            script = scripts[choice-1]
            print(f'\n--- Running {script} ---\n')
            try:
                exec(open(script).read(), globals())
            except Exception as e:
                print(f'Error running {script}: {e}')
            input('\nPress Enter to return to the menu...')
        else:
            print('Invalid choice. Please select a number from 0 to 10.')

if __name__ == '__main__':
    main()
