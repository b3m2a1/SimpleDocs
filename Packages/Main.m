(* ::Package:: *)

(* Autogenerated Package *)

(* ::Text:: *)
(*
	This is the main interface package, exposing all the stuff defined at the Package level in a consistent interface.
*)



SimpleDocs::usage=
  "The main interface to the SimpleDocs package";


Begin["`Private`"];


(* ::Subsection:: *)
(*Function*)



(* ::Subsubsection::Closed:: *)
(*Actions*)



$map=
  <|
    (* project related *)
    "BaseDirectory":>DocsProjectsDirectory,
    "SetBaseDirectory":>SetDocsProjectsDirectory,
    "ProjectPath"->($DocsProjectPath&),
    "ListProjects"->ListDocsProjects,
    "ListSymbolPages"->ListProjectSymbolPages,
    "ListGuidePages"->ListProjectGuidePages,
    "ListTutorialPages"->ListProjectTutorialPages,
    "Projects"->DocsProjects,
    "SetProjectOptions"->SetProjectOptions,
    "RemoveProject"->RemoveProject,
    "LoadProject"->LoadProjectConfig,
    "ReloadProject"->ReloadProjectConfig,
    "EnsureLoadProject"->EnsureLoadProject,
    "InitializeProject"->InitializeDocsProject,
    "OpenConfig"->OpenProjectConfig,
    (* paclet related *)
    "CreateDocumentationPaclet"->CreateDocumentationPaclet,
    "SetPacletInfo"->SetPacletInfo,
    "BundlePaclet"->BundlePaclet,
    (* site related *)
    "InitializeSite"->InitializeDocsSite,
    "BuildSite"->BuildDocsSite,
    "OpenSiteConfig"->OpenDocsSiteConfig,
    "ViewLocalSite"->OpenLocalDocsSite,
    (* notebok related *)
    "TemplateNotebook"->CreateTemplateNotebook,
    "SampleNotebook"->SampleTemplateNotebook,
    "SetProject"->SetNotebookProject,
    "SaveNotebook"->CheckSaveNotebook,
    "SaveToDocumentation"->SaveNotebookToDocumentation,
    "SaveToMarkdown"->SaveNotebookMarkdown,
    "SaveToProject"->SaveNotebookToProject
    |>;


(* ::Subsubsection::Closed:: *)
(*MethodQ*)



methodQ[arg_]:=
  KeyExistsQ[$map, arg]


(* ::Subsubsection::Closed:: *)
(*SimpleDocs*)



SimpleDocs//Clear;
SimpleDocs["<Method>", "Function"]~PackageAddUsage~
  "returns the function for the call into \"<Method>\" ";
SimpleDocs["<Method>", args..]~PackageAddUsage~
  "calls the function for \"<Method>\" on args";
SimpleDocs["<Method>"[args...]]~PackageAddUsage~
  "calls the function for \"<Method>\" on args";
SimpleDocs[k_String?methodQ, "Function"]:=
  $map[k];
SimpleDocs[k_String?methodQ, args__]:=
  With[{f=$map[k]},
    With[{r=PackageExceptionBlock["SimpleDocs"]@f[args]},
      r/;Head[r]===f
      ]
    ];
SimpleDocs[k_String?methodQ[args___]]:=
  With[{f=$map[k]},
    With[{r=PackageExceptionBlock["SimpleDocs"]@f[args]},
      r/;Head[r]=!=f
      ]
    ];
SimpleDocs[head:Except[_String][stuff___]]:=
  With[{h=Evaluate@head},
    SimpleDocs[h[stuff]]/;methodQ[h]
    ];
SimpleDocs[head:Except[_String], stuff__]:=
  With[{h=Evaluate@head},
    SimpleDocs[h, stuff]/;methodQ[h]
    ];
SimpleDocs~SetAttributes~HoldAllComplete


(* ::Subsection:: *)
(*Autocompletions*)



PackageAddAutocompletions[
  SimpleDocs,
  {
    Keys@$map,
    {"Function"}
    }
  ]


End[];



