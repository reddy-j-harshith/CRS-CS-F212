import cx_Oracle as cx
from fastapi import FastAPI, status, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from .models import Query, Rental, User, Bicycle
import uvicorn

app = FastAPI()

# Allow all origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
)

connStr = 'crs/crs123@localhost:1521/xepdb1'

def get_connection():
    try:
        conn = cx.connect(connStr)
        conn.autocommit = False
        return conn
    except cx.Error as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(e))

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

@app.post("/rental", status_code=status.HTTP_200_OK)
async def insert_rental(rental: Rental):
    conn = get_connection()
    try:
        # Set default values for fields
        rental_status = 'ACTIVE'
        return_date = None

        # Insert rental record into database
        cursor = conn.cursor()

        cursor.execute(
            """
            INSERT INTO rental_table 
            (borrower_id, bicycle_id, deadline, late_fees, damage_fees, amt_due, rental_status, return_date)
            VALUES (:borrower_id, :bicycle_id, TO_DATE(:deadline, 'YYYY-MM-DD'), 
                    :late_fees, :damage_fees, :amt_due, :rental_status, :return_date)
            """,
            borrower_id=rental.borrower_id,
            bicycle_id=rental.bicycle_id,
            deadline=rental.deadline,
            late_fees=rental.late_fees,
            damage_fees=rental.damage_fees,
            amt_due=rental.amt_due,
            rental_status=rental_status,
            return_date=return_date
        )
        conn.commit()
        
        return {"message": "Rental record inserted successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.post("/insert-user")
async def insert_user(user: User):
    conn = get_connection()
    try:
        # Insert user information into the database
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO user_info (user_id, firstname, lastname, email_address, gender, user_type) VALUES (:user_id, :first_name, :last_name, :email_address, :gender, :user_type)",
            user_id=user.user_id,
            first_name=user.firstname,
            last_name=user.lastname,
            email_address=user.email_address,
            gender=user.gender,
            user_type=user.user_type
        )
        conn.commit()

        return {"message": "User information inserted successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.post("/insert-bicycle")
async def create_bicycle(bicycle: Bicycle):
    conn = get_connection()
    try:
        # Insert bicycle data into the database
        cursor=conn.cursor()
        cursor.execute(
            "INSERT INTO bicycle (bicycle_type, lender_id, model_type) VALUES (:bicycle_type, :lender_id, :model_type)",
            bicycle_type=bicycle.bicycle_type,
            lender_id=bicycle.lender_id,
            model_type=bicycle.model_type
        )
        conn.commit()

        return {"message": "Bicycle inserted successfully"}
    except cx.Error as e:
        error, = e.args
        raise HTTPException(status_code=500, detail=str(error))
