-- Created by Redgate Data Modeler (https://datamodeler.redgate-platform.com)
-- Last modification date: 2025-11-27 21:25:42.212
DROP TABLE IF EXISTS 
    Gifting,
    Offer_Outlet,
    saved_offer,
    redemption,
    promo_payment,
    paypal_payment,
    card_payment,
    applepay_payment,
    payment,
    subscription,
    outlet,
    offer,
    brand_admin,
    system_admin,
    brand,
    category,
    customer,
    app_user
    CASCADE;

-- tables
-- Table: Gifting
CREATE TABLE Gifting (
    OfferID int  NOT NULL,
    UserID int  NOT NULL,
    GiftID int  NOT NULL,
    GiftDate timestamp  NOT NULL,
    RecipientPhone text  NOT NULL,
    GiftStatus text  NOT NULL,
    CONSTRAINT Gifting_pk PRIMARY KEY (GiftID,UserID,OfferID)
);

-- Table: Offer_Outlet
CREATE TABLE Offer_Outlet (
    OfferID int  NOT NULL,
    OutletID int  NOT NULL,
    CONSTRAINT Offer_Outlet_pk PRIMARY KEY (OfferID,OutletID)
);

-- Table: app_user
CREATE TABLE app_user (
    UserID int NOT NULL, 
    MobileNumber varchar(20)  NOT NULL,
    Email varchar(255)  NOT NULL,
    Name varchar(255)  NOT NULL,
    DateJoined date  NOT NULL,
    PreferredLanguage varchar(50)  NOT NULL,
    CreatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    UpdatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    Gender varchar(20)  NULL,
    Nationality varchar(100)  NULL,
    CONSTRAINT AK_0 UNIQUE (MobileNumber) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT app_user_pk PRIMARY KEY (UserID)
);

-- Table: applepay_payment
CREATE TABLE applepay_payment (
    PaymentID int  NOT NULL,
    ApplePayTransactionID varchar(100)  NOT NULL,
    ApplePayToken varchar(255)  NOT NULL,
    ApplePayMerchantID varchar(100)  NOT NULL,
    ApplePayEmail varchar(255)  NOT NULL,
    PaymentStatus varchar(50)  NOT NULL,
    CONSTRAINT applepay_payment_pk PRIMARY KEY (PaymentID)
);

-- Table: brand
CREATE TABLE brand (
    BrandID int  NOT NULL,
    CategoryID int  NOT NULL,
    Name varchar(255)  NOT NULL,
    Description text  NOT NULL,
    CreatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    Images text  NOT NULL,
    CONSTRAINT brand_pk PRIMARY KEY (BrandID)
);

-- Table: brand_admin
CREATE TABLE brand_admin (
    UserID int  NOT NULL,
    MerchantID int  NOT NULL,
    BusinessRole varchar(100)  NOT NULL,
    CONSTRAINT brand_admin_pk PRIMARY KEY (UserID)
);

-- Table: card_payment
CREATE TABLE card_payment (
    PaymentID int  NOT NULL,
    CardNumber varchar(32)  NOT NULL,
    CardType varchar(50)  NOT NULL,
    ExpiryDate date  NOT NULL,
    BankName varchar(100)  NOT NULL,
    CVV varchar(10)  NOT NULL,
    CONSTRAINT card_payment_pk PRIMARY KEY (PaymentID)
);

-- Table: category
CREATE TABLE category (
    CategoryID int  NOT NULL,
    Name varchar(100)  NOT NULL,
    Description text  NULL,
    CategoryImage text  NOT NULL,
    CONSTRAINT category_pk PRIMARY KEY (CategoryID)
);

-- Table: customer
CREATE TABLE customer (
    UserID int  NOT NULL,
    TotalRedemptions int  NOT NULL DEFAULT 0,
    LoyaltyPoints int  NULL,
    CONSTRAINT AK_1 UNIQUE (UserID) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT customer_pk PRIMARY KEY (UserID)
);

-- Table: offer
CREATE TABLE offer (
    OfferID int  NOT NULL,
    BrandID int  NOT NULL,
    Title varchar(255)  NOT NULL,
    Description text  NULL,
    OfferType varchar(50)  NOT NULL,
    ValidFrom date  NOT NULL,
    ValidUntil date  NOT NULL,
    RenewalPeriod int  NOT NULL,
    IsGiftable boolean  NOT NULL DEFAULT false,
    MaxUsesPerUserPerCycle int  NOT NULL,
    CreatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    UpdatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    SavingAmount numeric(10,2)  NOT NULL,
    DetailsInclusions text  NOT NULL,
    ShareLinkForm varchar(255)  NOT NULL,
    PostedBy int  NOT NULL,
    ApprovedBy int  NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (OfferID)
);

-- Table: outlet
CREATE TABLE outlet (
    OutletID int NOT NULL,
    BrandID int  NOT NULL,
    Name varchar(255)  NOT NULL,
    LocationAddress text  NOT NULL,
    City varchar(100)  NOT NULL,
    Country varchar(100)  NOT NULL,
    PhoneNumber varchar(30)  NULL,
    Status varchar(20)  NOT NULL,
    CONSTRAINT outlet_pk PRIMARY KEY (OutletID)
);

-- Table: payment
CREATE TABLE payment (
    PaymentID int  NOT NULL,
    SubscriptionID int  NOT NULL,
    Amount numeric(10,2)  NOT NULL,
    Currency varchar(10)  NOT NULL,
    PaymentMethod varchar(30)  NOT NULL,
    InvoiceNumber varchar(50)  NOT NULL,
    CreatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    UpdatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    CONSTRAINT AK_2 UNIQUE (InvoiceNumber) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT payment_pk PRIMARY KEY (PaymentID)
);

-- Table: paypal_payment
CREATE TABLE paypal_payment (
    PaymentID int  NOT NULL,
    PaypalTransactionID varchar(100)  NOT NULL,
    PaypalPayerID varchar(100)  NOT NULL,
    PaypalEmail varchar(255)  NOT NULL,
    PaymentIntent varchar(50)  NOT NULL,
    PaymentStatus varchar(50)  NOT NULL,
    CONSTRAINT paypal_payment_pk PRIMARY KEY (PaymentID)
);

-- Table: promo_payment
CREATE TABLE promo_payment (
    PaymentID int  NOT NULL,
    PromoCode varchar(50)  NOT NULL,
    DiscountValue numeric(10,2)  NOT NULL,
    ValidatedBy int  NOT NULL,
    CONSTRAINT promo_payment_pk PRIMARY KEY (PaymentID)
);

-- Table: redemption
CREATE TABLE redemption (
    RedemptionID int  NOT NULL,
    OfferID int  NOT NULL,
    UserID int  NOT NULL,
    OutletID int  NOT NULL,
    RedemptionDate timestamp  NOT NULL,
    MerchantPinEntered varchar(20)  NOT NULL,
    Status varchar(20)  NOT NULL,
    CreatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    CONSTRAINT redemption_pk PRIMARY KEY (RedemptionID)
);

-- Table: saved_offer
CREATE TABLE saved_offer (
    UserID int  NOT NULL,
    OfferID int  NOT NULL,
    SavedAt timestamp  NOT NULL DEFAULT current_timestamp,
    CONSTRAINT saved_offer_pk PRIMARY KEY (OfferID,UserID)
);

-- Table: subscription
CREATE TABLE subscription (
    SubscriptionID int  NOT NULL,
    UserID int  NOT NULL,
    SubscriptionStatus varchar(20)  NOT NULL,
    SubscriptionStartDate date  NOT NULL,
    SubscriptionEndDate date  NOT NULL,
    CONSTRAINT subscription_pk PRIMARY KEY (SubscriptionID)
);

-- Table: system_admin
CREATE TABLE system_admin (
    UserID int  NOT NULL,
    AccessLevel varchar(50)  NOT NULL,
    RoleTitle varchar(100)  NOT NULL,
    LastLogin timestamp  NOT NULL,
    IsActive boolean  NOT NULL DEFAULT true,
    CONSTRAINT system_admin_pk PRIMARY KEY (UserID)
);

-- foreign keys
-- Reference: FK_0 (table: brand)
ALTER TABLE brand ADD CONSTRAINT FK_0
    FOREIGN KEY (CategoryID)
    REFERENCES category (CategoryID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_1 (table: customer)
ALTER TABLE customer ADD CONSTRAINT FK_1
    FOREIGN KEY (UserID)
    REFERENCES app_user (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_10 (table: payment)
ALTER TABLE payment ADD CONSTRAINT FK_10
    FOREIGN KEY (SubscriptionID)
    REFERENCES subscription (SubscriptionID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_11 (table: paypal_payment)
ALTER TABLE paypal_payment ADD CONSTRAINT FK_11
    FOREIGN KEY (PaymentID)
    REFERENCES payment (PaymentID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_12 (table: card_payment)
ALTER TABLE card_payment ADD CONSTRAINT FK_12
    FOREIGN KEY (PaymentID)
    REFERENCES payment (PaymentID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_13 (table: applepay_payment)
ALTER TABLE applepay_payment ADD CONSTRAINT FK_13
    FOREIGN KEY (PaymentID)
    REFERENCES payment (PaymentID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_14 (table: promo_payment)
ALTER TABLE promo_payment ADD CONSTRAINT FK_14
    FOREIGN KEY (PaymentID)
    REFERENCES payment (PaymentID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_15 (table: promo_payment)
ALTER TABLE promo_payment ADD CONSTRAINT FK_15
    FOREIGN KEY (ValidatedBy)
    REFERENCES system_admin (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_16 (table: redemption)
ALTER TABLE redemption ADD CONSTRAINT FK_16
    FOREIGN KEY (OfferID)
    REFERENCES offer (OfferID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_17 (table: redemption)
ALTER TABLE redemption ADD CONSTRAINT FK_17
    FOREIGN KEY (UserID)
    REFERENCES customer (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_18 (table: redemption)
ALTER TABLE redemption ADD CONSTRAINT FK_18
    FOREIGN KEY (OutletID)
    REFERENCES outlet (OutletID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_2 (table: system_admin)
ALTER TABLE system_admin ADD CONSTRAINT FK_2
    FOREIGN KEY (UserID)
    REFERENCES app_user (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_20 (table: saved_offer)
ALTER TABLE saved_offer ADD CONSTRAINT FK_20
    FOREIGN KEY (OfferID)
    REFERENCES offer (OfferID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_3 (table: brand_admin)
ALTER TABLE brand_admin ADD CONSTRAINT FK_3
    FOREIGN KEY (UserID)
    REFERENCES app_user (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_4 (table: brand_admin)
ALTER TABLE brand_admin ADD CONSTRAINT FK_4
    FOREIGN KEY (MerchantID)
    REFERENCES brand (BrandID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_5 (table: offer)
ALTER TABLE offer ADD CONSTRAINT FK_5
    FOREIGN KEY (BrandID)
    REFERENCES brand (BrandID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_6 (table: offer)
ALTER TABLE offer ADD CONSTRAINT FK_6
    FOREIGN KEY (PostedBy)
    REFERENCES brand_admin (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_7 (table: offer)
ALTER TABLE offer ADD CONSTRAINT FK_7
    FOREIGN KEY (ApprovedBy)
    REFERENCES system_admin (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_8 (table: outlet)
ALTER TABLE outlet ADD CONSTRAINT FK_8
    FOREIGN KEY (BrandID)
    REFERENCES brand (BrandID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_9 (table: subscription)
ALTER TABLE subscription ADD CONSTRAINT FK_9
    FOREIGN KEY (UserID)
    REFERENCES customer (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Gifting_customer (table: Gifting)
ALTER TABLE Gifting ADD CONSTRAINT Gifting_customer
    FOREIGN KEY (UserID)
    REFERENCES customer (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Gifting_offer (table: Gifting)
ALTER TABLE Gifting ADD CONSTRAINT Gifting_offer
    FOREIGN KEY (OfferID)
    REFERENCES offer (OfferID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Offer_Outlet_offer (table: Offer_Outlet)
ALTER TABLE Offer_Outlet ADD CONSTRAINT Offer_Outlet_offer
    FOREIGN KEY (OfferID)
    REFERENCES offer (OfferID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Offer_Outlet_outlet (table: Offer_Outlet)
ALTER TABLE Offer_Outlet ADD CONSTRAINT Offer_Outlet_outlet
    FOREIGN KEY (OutletID)
    REFERENCES outlet (OutletID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: customer_saved_offer (table: saved_offer)
ALTER TABLE saved_offer ADD CONSTRAINT customer_saved_offer
    FOREIGN KEY (UserID)
    REFERENCES customer (UserID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

