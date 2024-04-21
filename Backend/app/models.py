from pydantic import BaseConfig, BaseModel
from typing import List

class Query(BaseModel):
    query: str

class User(BaseModel):
    user_id: str
    firstname: str
    lastname: str
    email_address: str
    gender: str
    user_type: str
    phones: List[str]

class Bicycle(BaseModel):
    bicycle_type: str
    lender_id: str
    model_type: str
    colors: List[str]
    class Config(BaseConfig):
        protected_namespaces = ()

class Extension(BaseModel):
    rental_id: int
    extra_duration: int
    
class Feedback(BaseModel):
    user_id: str
    rating: int
    comments: str

class Rental(BaseModel):
    borrower_id: str
    bicycle_id: int
    rental_date: str

class Confirmer(BaseModel):
    rental_id: int
    return_date: str
    damaged_flag: str

class deleteUser(BaseModel):
    user_id: str

class deleteBicycle(BaseModel):
    bicycle_id: int
