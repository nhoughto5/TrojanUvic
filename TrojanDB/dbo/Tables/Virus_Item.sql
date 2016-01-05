CREATE TABLE [dbo].[Virus_Item] (
    [ItemId]              NVARCHAR (128) NOT NULL,
    [VirusId]             NVARCHAR (MAX) NULL,
    [On_Off]              BIT            NOT NULL,
    [DateCreated]         DATETIME       NOT NULL,
    [AttributeId]         INT            NOT NULL,
    [userAdded]           BIT            NOT NULL,
    [Saved]               BIT            NOT NULL,
    [Category_CategoryId] INT            NULL,
    [Virus_id]            INT            NULL,
    CONSTRAINT [PK_dbo.Virus_Item] PRIMARY KEY CLUSTERED ([ItemId] ASC),
    CONSTRAINT [FK_dbo.Virus_Item_dbo.Attributes_AttributeId] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[Attributes] ([AttributeId]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.Virus_Item_dbo.Categories_Category_CategoryId] FOREIGN KEY ([Category_CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]),
    CONSTRAINT [FK_dbo.Virus_Item_dbo.Virus_Virus_id] FOREIGN KEY ([Virus_id]) REFERENCES [dbo].[Virus] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IX_AttributeId]
    ON [dbo].[Virus_Item]([AttributeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Category_CategoryId]
    ON [dbo].[Virus_Item]([Category_CategoryId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Virus_id]
    ON [dbo].[Virus_Item]([Virus_id] ASC);

