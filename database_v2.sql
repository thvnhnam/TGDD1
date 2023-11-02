--New Database: StoreMgmt
--Bang Category
CREATE TABLE [dbo].[Category] (  
    [CatID]				INT   IDENTITY (1, 1) NOT NULL,
    [NameCate]			NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([CatID] ASC)
);
--Bang Supplier
CREATE TABLE [dbo].[Supplier]
(
    [SupID]				INT IDENTITY (1, 1) NOT NULL,
    [SupName]			NVARCHAR(MAX) NOT NULL, 
    [Address]			NVARCHAR(MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([SupID] ASC)
)
--Bang Color
CREATE TABLE [dbo].[Color]
(
    [ColorID]			INT IDENTITY (1, 1) NOT NULL,
    [ColorName]			NVARCHAR(MAX) NOT NULL, 
    [RGB]				NCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([ColorID] ASC)
)
--Bang Product
CREATE TABLE [dbo].[Product] (
    [ProID]				INT  IDENTITY (1, 1) NOT NULL,
    [ProName]			NVARCHAR (MAX)  NULL,
    [CatID]				int not NULL,
    [ProImage]			NVARCHAR (MAX)  NULL,
	[NameDecription]	NVARCHAR (MAX)  NULL,
	[CreatedDate]		DATE NOT NULL,
    PRIMARY KEY CLUSTERED ([ProID] ASC),
    CONSTRAINT [FK_Pro_Category] FOREIGN KEY ([CatID]) REFERENCES [dbo].[Category] ([CatID])
);
CREATE TABLE [dbo].[ProDetail] (
    [ProDeID]			INT IDENTITY (1, 1) NOT NULL,
    [ProID]				INT NOT NULL,
    [SupID]				INT NOT NULL,
	[ColorID]			INT NOT NULL,
	[Price]				FLOAT (53) NOT NULL,
	[RemainQuantity]	INT NOT NULL,
	[SoldQuantity]		INT NULL DEFAULT 0,
	[ViewQuantity]		INT NULL DEFAULT 0,
    PRIMARY KEY CLUSTERED ([ProDeID] ASC),
    FOREIGN KEY ([ProID]) REFERENCES [dbo].[Product] ([ProID]) ON DELETE CASCADE,
    FOREIGN KEY ([SupID]) REFERENCES [dbo].[Supplier] ([SupID]) ON DELETE CASCADE,
	FOREIGN KEY ([ColorID]) REFERENCES [dbo].[Color] ([ColorID]) ON DELETE CASCADE
)
-- Bang AdminUser
CREATE TABLE [dbo].[User] (
    [Username]			NVARCHAR (50) PRIMARY KEY NOT NULL,
    [Password]			NVARCHAR (50)     NOT NULL,
	[Role]				NVARCHAR (50) NOT NULL--,
);
--Bang Customer
CREATE TABLE [dbo].[Customer] (
	[CusPhone]			NVARCHAR (15) PRIMARY KEY NOT NULL,
	[CusPassword]		NVARCHAR(50) NOT NULL,
	[CusName]			NVARCHAR (MAX) NULL,
    [CusEmail]			NVARCHAR (MAX) NULL,
);
--Bang Order
CREATE TABLE [dbo].[Order] (
    [OrderID]			INT            IDENTITY (1, 1) NOT NULL,
    [OrderDate]			DATE           NULL,
	[CusPhone]			NVARCHAR (15) NOT NULL,
    [AddressDeliverry]	NVARCHAR (MAX) NULL,
	[TotalValue]		FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC),
    FOREIGN KEY ([CusPhone]) REFERENCES [dbo].[Customer] ([CusPhone])
);
--Bang OrderDetail
CREATE TABLE [dbo].[OrderDetail] (
    [OrderDetailID]		INT        IDENTITY (1, 1) NOT NULL,
    [ProSupID]			INT        NULL,
    [OrderID]			INT        NULL,
    [Quantity]			INT        NULL,
    [UnitPrice]			FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([OrderDetailID] ASC),
    FOREIGN KEY ([ProSupID]) REFERENCES [dbo].[ProDetail] ([ProDeID]),
    FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order] ([OrderID])
);