import sqlite3
con = sqlite3.connect('db.sqlite3')
id = 80
data = [
    [23.036790259959968, 72.55313405147471],
    [23.037757029813726, 72.55306977813865],
    [23.03773290573648, 72.55252533780937],
    [23.038789945300895, 72.55296401079381],
    [23.03783727730775, 72.55306880682541],
    [23.037852722957272, 72.55429472876706]
]
walkable = True

cur = con.cursor()

for i in range(0, 6):

    lat = data[i][0]
    lan = data[i][1]
    query = ''' INSERT INTO map_coordinate (id,latitude,longitude,walkable)  VALUES (?,? ,?,?)'''
    cur.execute(query, (id, lat, lan, walkable))
    id += 1
con.commit()
print(con)
