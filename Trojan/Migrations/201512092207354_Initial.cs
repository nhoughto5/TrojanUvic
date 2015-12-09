namespace Trojan.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Attributes",
                c => new
                    {
                        AttributeId = c.Int(nullable: false, identity: true),
                        AttributeName = c.String(nullable: false, maxLength: 100),
                        Description = c.String(nullable: false),
                        ImagePath = c.String(),
                        F_in = c.Int(nullable: false),
                        F_out = c.Int(nullable: false),
                        CategoryId = c.Int(nullable: false),
                        CategoryName = c.String(),
                    })
                .PrimaryKey(t => t.AttributeId)
                .ForeignKey("dbo.Categories", t => t.CategoryId, cascadeDelete: true)
                .Index(t => t.CategoryId);
            
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        CategoryId = c.Int(nullable: false, identity: true),
                        CategoryName = c.String(nullable: false, maxLength: 100),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.CategoryId);
            
            CreateTable(
                "dbo.Connections",
                c => new
                    {
                        ConnectionId = c.Int(nullable: false, identity: true),
                        source = c.Int(nullable: false),
                        target = c.Int(nullable: false),
                        direct = c.Boolean(nullable: false),
                        VirusId = c.String(),
                    })
                .PrimaryKey(t => t.ConnectionId);
            
            CreateTable(
                "dbo.Matrix_Cell",
                c => new
                    {
                        CellId = c.Int(nullable: false, identity: true),
                        RowId = c.Int(nullable: false),
                        ColumnId = c.Int(nullable: false),
                        value = c.Boolean(),
                        submatrix = c.String(),
                        MatrixMatrix_Id = c.Int(nullable: false),
                        MatrixName = c.String(),
                    })
                .PrimaryKey(t => t.CellId);
            
            CreateTable(
                "dbo.severityRatings",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        VirusId = c.String(),
                        Saved = c.Boolean(nullable: false),
                        coverage = c.Boolean(nullable: false),
                        nickName = c.String(),
                        userName = c.String(),
                        iR = c.String(),
                        iA = c.String(),
                        iE = c.String(),
                        iL = c.String(),
                        iF = c.String(),
                        iC = c.String(),
                        iP = c.String(),
                        iO = c.String(),
                        cR = c.String(),
                        cA = c.String(),
                        cE = c.String(),
                        cL = c.String(),
                        cF = c.String(),
                        cC = c.String(),
                        cP = c.String(),
                        cO = c.String(),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.Virus",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        userName = c.String(),
                        virusId = c.String(),
                        virusNickName = c.String(),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.Virus_Item",
                c => new
                    {
                        ItemId = c.String(nullable: false, maxLength: 128),
                        VirusId = c.String(),
                        On_Off = c.Boolean(nullable: false),
                        DateCreated = c.DateTime(nullable: false),
                        AttributeId = c.Int(nullable: false),
                        userAdded = c.Boolean(nullable: false),
                        Saved = c.Boolean(nullable: false),
                        Category_CategoryId = c.Int(),
                        Virus_id = c.Int(),
                    })
                .PrimaryKey(t => t.ItemId)
                .ForeignKey("dbo.Attributes", t => t.AttributeId, cascadeDelete: true)
                .ForeignKey("dbo.Categories", t => t.Category_CategoryId)
                .ForeignKey("dbo.Virus", t => t.Virus_id)
                .Index(t => t.AttributeId)
                .Index(t => t.Category_CategoryId)
                .Index(t => t.Virus_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Virus_Item", "Virus_id", "dbo.Virus");
            DropForeignKey("dbo.Virus_Item", "Category_CategoryId", "dbo.Categories");
            DropForeignKey("dbo.Virus_Item", "AttributeId", "dbo.Attributes");
            DropForeignKey("dbo.Attributes", "CategoryId", "dbo.Categories");
            DropIndex("dbo.Virus_Item", new[] { "Virus_id" });
            DropIndex("dbo.Virus_Item", new[] { "Category_CategoryId" });
            DropIndex("dbo.Virus_Item", new[] { "AttributeId" });
            DropIndex("dbo.Attributes", new[] { "CategoryId" });
            DropTable("dbo.Virus_Item");
            DropTable("dbo.Virus");
            DropTable("dbo.severityRatings");
            DropTable("dbo.Matrix_Cell");
            DropTable("dbo.Connections");
            DropTable("dbo.Categories");
            DropTable("dbo.Attributes");
        }
    }
}
