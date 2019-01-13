(* ::Package:: *)

{
	"Mode" -> "Primary",
	"Dependencies" -> {
		{
			"BTools`",
			"RemovePaths" -> {
				ParentList,
				"Documentation",
				"Resources/Templates",
				"Resources/PaletteGenerators",
				"Resources/Themes/minimal",
				"FrontEnd/Palettes"
			}
		},
		{
			"Ems`",
			"LoadInfo" -> {"Dependencies" -> {"BTools`"}}
		}
	},
	"DependencyContexts" -> {
		"Ems`",
		"BTools`Developer`",
		"BTools`Web`",
		"BTools`Web`Markdown`",
		"BTools`Paclets`",
		"BTools`Paclets`DocGen`",
		"BTools`External`"
	},
	"PreLoad" -> None,
	"FEHidden" -> {},
	"PackageScope" -> None
}
