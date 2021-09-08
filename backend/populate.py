import sqlite3
con = sqlite3.connect('db.sqlite3')
id = 99
data = [
    
    [23.0367305729647, 72.55269946406895],
    [23.037737815562146, 72.55248518168588],
    [23.037768841625727, 72.55306812942518],
    [23.038782956917604, 72.55296561791928],
    [23.036801888748315, 72.55313540155926],
    
]
walkable = True


cur = con.cursor()

for i in range(0, 5):

    lat = data[i][0]
    lan = data[i][1]
    query = ''' INSERT INTO map_coordinate (id,latitude,longitude,walkable)  VALUES (?,? ,?,?)'''
    cur.execute(query, (id, lat, lan, walkable))
    id += 1
con.commit()
print(con)
