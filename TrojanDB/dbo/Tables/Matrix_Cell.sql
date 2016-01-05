CREATE TABLE [dbo].[Matrix_Cell] (
    [CellId]          INT            IDENTITY (1, 1) NOT NULL,
    [RowId]           INT            NOT NULL,
    [ColumnId]        INT            NOT NULL,
    [value]           BIT            NULL,
    [submatrix]       NVARCHAR (MAX) NULL,
    [MatrixMatrix_Id] INT            NOT NULL,
    [MatrixName]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Matrix_Cell] PRIMARY KEY CLUSTERED ([CellId] ASC)
);

