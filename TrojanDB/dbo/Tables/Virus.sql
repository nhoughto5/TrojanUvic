CREATE TABLE [dbo].[Virus] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [userName]      NVARCHAR (MAX) NULL,
    [virusId]       NVARCHAR (MAX) NULL,
    [virusNickName] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Virus] PRIMARY KEY CLUSTERED ([id] ASC)
);

