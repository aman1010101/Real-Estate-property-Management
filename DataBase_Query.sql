-- Table to store user information
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each user
    Username VARCHAR(50) UNIQUE NOT NULL, -- Unique username for the user
    Password VARCHAR(100) NOT NULL, -- User password
    FullName VARCHAR(100), -- Full name of the user
    Email VARCHAR(100) UNIQUE, -- User email address (must be unique)
    Phone VARCHAR(15), -- User phone number
    Role ENUM('Admin', 'Agent', 'User') NOT NULL, -- Role of the user in the system
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the user was created
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Timestamp when the user was last updated
);

-- Table to store property details
CREATE TABLE Properties (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each property
    Title VARCHAR(255) NOT NULL, -- Title or name of the property
    Description TEXT, -- Detailed description of the property
    Address VARCHAR(255), -- Street address of the property
    City VARCHAR(100), -- City where the property is located
    State VARCHAR(100), -- State where the property is located
    ZipCode VARCHAR(20), -- Zip code of the property's location
    Price DECIMAL(15, 2), -- Price of the property
    PropertyType ENUM('Apartment', 'House', 'Condo', 'Land', 'Commercial') NOT NULL, -- Type of property
    Status ENUM('Available', 'Sold', 'Rented') DEFAULT 'Available', -- Current status of the property
    ListedBy INT, -- UserID of the user who listed the property
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the property was created
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Timestamp when the property was last updated
    FOREIGN KEY (ListedBy) REFERENCES Users(UserID) -- Foreign key constraint to reference the user who listed the property
);

-- Table to store images related to properties
CREATE TABLE PropertyImages (
    ImageID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each image
    PropertyID INT, -- Foreign key referencing the property to which the image belongs
    ImageURL VARCHAR(255), -- URL of the property image
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID) -- Foreign key constraint to reference the property
);

-- Table to store user's favorite properties
CREATE TABLE Favorites (
    FavoriteID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each favorite entry
    UserID INT, -- Foreign key referencing the user who marked the property as favorite
    PropertyID INT, -- Foreign key referencing the property marked as favorite
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the favorite entry was created
    FOREIGN KEY (UserID) REFERENCES Users(UserID), -- Foreign key constraint to reference the user
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID) -- Foreign key constraint to reference the property
);

-- Table to store inquiries made by users about properties
CREATE TABLE Inquiries (
    InquiryID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each inquiry
    UserID INT, -- Foreign key referencing the user who made the inquiry
    PropertyID INT, -- Foreign key referencing the property the inquiry is about
    Message TEXT, -- Message content of the inquiry
    Status ENUM('Pending', 'Resolved') DEFAULT 'Pending', -- Status of the inquiry (Pending or Resolved)
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the inquiry was created
    FOREIGN KEY (UserID) REFERENCES Users(UserID), -- Foreign key constraint to reference the user
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID) -- Foreign key constraint to reference the property
);

-- Table to store various reports generated in the system
CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each report
    ReportType ENUM('UserActivity', 'PropertyStats', 'Financial') NOT NULL, -- Type of the report
    Description TEXT, -- Description or content of the report
    GeneratedBy INT, -- Foreign key referencing the user who generated the report
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the report was created
    FOREIGN KEY (GeneratedBy) REFERENCES Users(UserID) -- Foreign key constraint to reference the user
);

-- Table to store transactions for property sales or rentals
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each transaction
    PropertyID INT, -- Foreign key referencing the property involved in the transaction
    BuyerID INT, -- Foreign key referencing the user who is the buyer in the transaction
    SellerID INT, -- Foreign key referencing the user who is the seller in the transaction
    TransactionType ENUM('Sale', 'Rent') NOT NULL, -- Type of transaction (Sale or Rent)
    Amount DECIMAL(15, 2), -- Amount involved in the transaction
    TransactionDate DATE, -- Date when the transaction took place
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID), -- Foreign key constraint to reference the property
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID), -- Foreign key constraint to reference the buyer
    FOREIGN KEY (SellerID) REFERENCES Users(UserID) -- Foreign key constraint to reference the seller
);
