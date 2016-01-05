CREATE TABLE [dbo].[Attributes] (
    [AttributeId]   INT            IDENTITY (1, 1) NOT NULL,
    [AttributeName] NVARCHAR (100) NOT NULL,
    [Description]   NVARCHAR (MAX) NOT NULL,
    [ImagePath]     NVARCHAR (MAX) NULL,
    [F_in]          INT            NOT NULL,
    [F_out]         INT            NOT NULL,
    [CategoryId]    INT            NOT NULL,
    [CategoryName]  NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Attributes] PRIMARY KEY CLUSTERED ([AttributeId] ASC),
    CONSTRAINT [FK_dbo.Attributes_dbo.Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_CategoryId]
    ON [dbo].[Attributes]([CategoryId] ASC);

