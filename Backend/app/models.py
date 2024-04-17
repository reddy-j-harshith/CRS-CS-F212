from datetime import date
from pydantic import BaseModel

class Query(BaseModel):
    query: str

class User(BaseModel):
    user_id: str
    first_name: str
    last_name: str
    email_address: str
    user_type: str
    gender: str

class Bicycle(BaseModel):
    bicycle_type: str
    lender_id: str
    model_type: str
    bicycle_status: str
    
class Extension(BaseModel):
    rental_id: str
    extra_duration: date
    ex_charges: int
    
class Rental(BaseModel):
    # rental_id -> Auto gen
    borrower_id: str
    bicycle_id: int
    deadline: date
    return_date: date
    return_status: str
    late_fees: int
    damage_fees: int
    amt_due: int
