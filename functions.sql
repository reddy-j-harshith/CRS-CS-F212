/*Function to retrieve average rating for a user's rental experiences (get_feedback_rating):*/

CREATE OR REPLACE FUNCTION get_feedback_rating (
    p_user_id IN user_info.user_id%TYPE
)
RETURN NUMBER
IS
    v_avg_rating NUMBER;
BEGIN
    SELECT AVG(rating)
    INTO v_avg_rating
    FROM feedback
    WHERE user_id = p_user_id;

    RETURN NVL(v_avg_rating, 0);
END get_feedback_rating;
/



/*Function to check bicycle availability (check_bicycle_availability):*/
CREATE OR REPLACE FUNCTION check_bicycle_availability (
    p_bicycle_id IN bicycle.bicycle_id%TYPE
)
RETURN BOOLEAN
IS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM bicycle
    WHERE bicycle_id = p_bicycle_id
    AND bicycle_status = 'available';

    RETURN v_count > 0;
END check_bicycle_availability;
/




/*Function to calculate total amount due for a rental (calculate_total_amount_due):*/
CREATE OR REPLACE FUNCTION calculate_total_amount_due (
    p_rental_id IN rental.rental_id%TYPE
)
RETURN NUMBER
IS
    v_total_amount NUMBER;
BEGIN
    SELECT 100 + NVL(late_fees, 0) + NVL(damage_fees, 0)
    INTO v_total_amount
    FROM rental
    WHERE rental_id = p_rental_id;

    RETURN v_total_amount;
END calculate_total_amount_due;
/


