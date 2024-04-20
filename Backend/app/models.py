from datetime import date
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
    rental_id: str
    extra_duration: date
    
class Feedback(BaseModel):
    rental_id: str
    rating: int
    comments: str

class Rental(BaseModel):
    borrower_id: str
    bicycle_id: int
    rental_date: str