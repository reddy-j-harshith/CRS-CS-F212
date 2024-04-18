from pydantic import BaseConfig, BaseModel

class Query(BaseModel):
    query: str

class User(BaseModel):
    user_id: str
    firstname: str
    lastname: str
    email_address: str
    gender: str
    user_type: str

class Bicycle(BaseModel):
    bicycle_type: str
    lender_id: str
    model_type: str
    class Config(BaseConfig):
        protected_namespaces = ()

class Extension(BaseModel):
    rental_id: str
    extra_duration: str
    ex_charges: int
    
class Rental(BaseModel):
    # rental_id -> Auto gen
    borrower_id: str
    bicycle_id: int
    deadline: str
    late_fees: int
    damage_fees: int
    amt_due: int
