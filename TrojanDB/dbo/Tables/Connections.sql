CREATE TABLE [dbo].[Connections] (
    [ConnectionId] INT            IDENTITY (1, 1) NOT NULL,
    [source]       INT            NOT NULL,
    [target]       INT            NOT NULL,
    [direct]       BIT            NOT NULL,
    [VirusId]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Connections] PRIMARY KEY CLUSTERED ([ConnectionId] ASC)
);

