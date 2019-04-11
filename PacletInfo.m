(* ::Package:: *)

Paclet[
  Name -> "SimpleDocs",
  Version -> "1.1.2",
  Creator -> "b3m2a1 <b3m2a1@gmail.com>",
  URL -> "https://github.com/b3m2a1/SimpleDocs",
  Thumbnail -> "Resources/icon.png",
  Extensions -> {
    	{
     		"Kernel",
     		"Root" -> ".",
     		"Context" -> {"SimpleDocs`"}
     	},
    	{"FrontEnd"},
    	{
     		"Documentation",
     		"Language" -> "English",
     		"MainPage" -> "Guides/SimpleDocs"
     	},
    	{
     		"Resource",
     		"Root" -> "Resources",
     		"Resources" -> {
       			{
        				"icon_big",
        				"icon_big.png"
        			},
       			{
        				"icon",
        				"icon.png"
        			},
       			{
        				"SimpleDocsHelperGenerator",
        				"SimpleDocsHelperGenerator.nb"
        			}
       		}
     	},
    	{
     		"PacletServer",
     		"Tags" -> {"documentation"},
     		"Categories" -> {"Development"},
     		"Description" -> 
      "A simple package to make simple documentation",
     		"License" -> "MIT"
     	}
    }
 ]
