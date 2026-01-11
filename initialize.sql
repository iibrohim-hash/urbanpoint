DROP DATABASE IF EXISTS urbanpoint;
CREATE DATABASE urbanpoint;
\c urbanpoint


\i create.sql


\copy category     FROM 'category.csv'     CSV HEADER;
\copy app_user     FROM 'app_user.csv'     CSV HEADER;
\copy customer     FROM 'customer.csv'     CSV HEADER;


\copy brand        FROM 'brand.csv'        CSV HEADER;
\copy brand_admin  FROM 'brand_admin.csv'  CSV HEADER;
\copy system_admin FROM 'system_admin.csv' CSV HEADER;


\copy outlet       FROM 'outlet.csv'       CSV HEADER;
\copy offer        FROM 'offer.csv'        CSV HEADER;


\copy offer_outlet FROM 'Offer_Outlet.csv' CSV HEADER;
\copy saved_offer  FROM 'saved_offer.csv'  CSV HEADER;
\copy gifting      FROM 'Gifting.csv'      CSV HEADER;
\copy redemption   FROM 'redemption.csv'   CSV HEADER;


\copy subscription FROM 'subscription.csv'  CSV HEADER;
\copy payment      FROM 'payment.csv'       CSV HEADER;


\copy paypal_payment   FROM 'paypal_payment.csv'   CSV HEADER;
\copy card_payment     FROM 'card_payment.csv'     CSV HEADER;
\copy applepay_payment FROM 'applepay_payment.csv' CSV HEADER;
\copy promo_payment    FROM 'promo_payment.csv'    CSV HEADER;


\echo UrbanPoint data load completed successfully

CREATE OR REPLACE FUNCTION check_unique_mobile()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM app_user 
        WHERE MobileNumber = NEW.MobileNumber
    ) THEN
        RAISE EXCEPTION
        'Mobile number % already exists. Cannot register duplicate users.', NEW.MobileNumber;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_unique_mobile
BEFORE INSERT ON app_user
FOR EACH ROW
EXECUTE FUNCTION check_unique_mobile();


CREATE OR REPLACE FUNCTION prevent_duplicate_outletid()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM outlet 
        WHERE OutletID = NEW.OutletID
    ) THEN
        RAISE EXCEPTION 
        'OutletID % already exists. Manual incrementing failed.', NEW.OutletID;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_no_duplicate_outletid
BEFORE INSERT ON outlet
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_outletid();

