import cx_Oracle as cx
from fastapi import FastAPI, status, HTTPException
from models import Query

app = FastAPI()

connStr = 'crs/crs123@localhost:1521/xepdb1'

def get_connection():
    try:
        conn = cx.connect(connStr)
        conn.autocommit = False
        return conn
    except cx.Error as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(e))

@app.get("/")
def welcome():
    return {"Message": "Welcome"}

@app.post("/query", status_code=status.HTTP_200_OK)
def query(query: Query):
    conn = get_connection()
    try:
        curr = conn.cursor()
        queries = query.query.split(';')
        for q in queries:
            if q.strip():
                curr.execute(q)
                if q.strip().upper().startswith('SELECT'):
                    output = curr.fetchall() # Fetch all the entities
                    columns = [desc[0] for desc in curr.description] # Get all the column names
                    results = [dict(zip(columns, row)) for row in output] # Attach all the entities with their respective attribute names.
                    return {"Data": results}
        conn.commit()
        return {"Message": "The queries have been successfully executed."}
    

    except cx.Error as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))
    finally:
        curr.close()  # Close cursor
        conn.close()  # Close connection
