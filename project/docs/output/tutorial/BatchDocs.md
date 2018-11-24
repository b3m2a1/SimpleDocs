Title: Making Batch Documentation
built: {2018, 11, 24, 2, 32, 42.741928}
context: SimpleDocs`
Date: 2018-11-24 03:16:04
history: 11.3,,
index: True
keywords: <||>
label: BatchDocs
language: en
Modified: 2018-11-24 03:16:06
paclet: Mathematica
specialkeywords: <||>
status: None
summary: 
synonyms: <||>
tabletags: <||>
title: Making Batch Documentation
titlemodifier: 
tutorialcollectionlinks: <||>
type: Tutorial
uri: SimpleDocs/tutorial/BatchDocs
windowtitle: Making Batch Documentation
WorkflowDockedCell: 

<a id="making-batch-documentation" style="width:0;height:0;margin:0;padding:0;">&zwnj;</a>

# Making Batch Documentation

One of the big benefits of having code to generate documentation like this (and having simple documentation to work with) is that we can deal with it programatically. That's not to say that we can do everything perfectly, but we can get the basic superstructure up and working and handle most of the boiler plate.

For this demo, we'll first figure out what functions still need to be documented:

    << SimpleDocs`Package`
    fns = Names["SimpleDocs`Package`*"]

    (*Out:*)
    
    {"BuildDocsSite","BuildNotebookDocsSite","CreateTemplateNotebook","InitializeDocsSite","OpenDocsSiteConfig","SampleTemplateNotebook","SaveNotebookMarkdown","SaveNotebookToPaclet","SaveNotebookToPacletProject","SetNotebookPaclet","SetPacletInfo","$DockedCell","$HamburgerMenu","$InsertionMenu","$MetadataEditor","$NotebookTemplates"}

    needDocs=
      Select[fns, 
      !FileExistsQ@
        FileNameJoin@{ParentDirectory@NotebookDirectory[], "ref", StringSplit[#, "`"]<>".nb"}&
      ]

    (*Out:*)
    
    {"BuildNotebookDocsSite","InitializeDocsSite","OpenDocsSiteConfig","SampleTemplateNotebook","SaveNotebookMarkdown","SaveNotebookToPaclet","SaveNotebookToPacletProject","SetNotebookPaclet","SetPacletInfo","$DockedCell","$HamburgerMenu","$InsertionMenu","$MetadataEditor","$NotebookTemplates"}

At this point we'll think about what we did in the basic  [SimpleDocs Usage](../tutorial/SimpleDocs.html) tutorial and just write code to do most of it:

* Generate function template with  [```CreateTemplateNotebook```](../ref/CreateTemplateNotebook.html)

* Save notebook to paclet

* Edit metadata to get the context and URI parts correct

* Change the little label bar to be correct

* Save the documentation notebook

* Save the Markdown

As an additional step, we'll add the related links I've been adding to all of the pages, which look like this:

![batchdocs-3557312341007022428](../img/batchdocs-3557312341007022428.png)

And then we'll just loop over the functions and do that at each step. So let's start. First, the function to make a template and get the  [```NotebookObject```](../ref/NotebookObject.html) reference. Well that's already basically there, so let's move to the next part, which is correcting the metadata:

    correctMetadata[nb_]:=
      (
        CurrentValue[nb, {TaggingRules, "Metadata", "context"}]=
          "SimpleDocs`";
        CurrentValue[nb, {TaggingRules, "Metadata", "uri"}]=
          StringReplace[
            CurrentValue[nb, {TaggingRules, "Metadata", "uri"}],
            "SimpleDocsPackage"->"SimpleDocs"
            ];
        )

That was easy. Okay. Next step is correcting the label cell. I called the cell style  ```"TitleBar"``` so we'll just find the first of that type of cell and change the body:

    correctTitleBar[nb_]:=
      With[{c=Cells[nb, CellStyle->"TitleBar"][[1]]},
        NotebookWrite[c, Cell["SimpleDocs Symbol", "TitleBar"]];
        ]

Then we'll replace the related bits. Let's just say I saved the collection of cells to a variable called  ```$relatedCells``` :

    correctRelatedStuff[nb_]:=
      Module[{cells, firstCell},
        firstCell=Cells[nb, CellStyle->"SeeAlso"][[1]];
        cells=
          Cells[nb, 
            CellStyle->"SeeAlso"|"Related"|"RelatedLinks"|"Footer"|"Text"|"Item"
            ];
        cells=Join@@SplitBy[cells, #=!=firstCell&][[2;;]];
        SelectionMove[cells[[-1]], After, Cell];
        NotebookDelete@cells;
        NotebookWrite[nb, $relatedCells]
        ];

Also easy. Finally, the saving steps are basically just functions in the package so we'll just chain this all together as:

    doTemplateDocs[fn_]:=
      Module[{nb, file, docs, md},
        nb=CreateTemplateNotebook@fn;
        CurrentValue[nb, {TaggingRules, "Paclet"}]="SimpleDocs";
        SaveNotebookToPacletProject[nb];
        file = NotebookFileName@nb;
        correctMetadata[nb];
        correctTitleBar[nb];
        correctRelatedStuff[nb];
        NotebookSave@nb;
        docs = SaveNotebookToPaclet[nb];
        md = SaveNotebookMarkdown[nb];
        NotebookClose@nb;
        <|
          "Notebook"->file,
          "Documentation"->docs,
          "Markdown"->md
          |>
        ]

Let's just check that this works cleanly on the first of our undocumented functions:

    doTemplateDocs@needDocs[[1]]

    (*Out:*)
    
    <|"Notebook"->"~/Documents/Wolfram Mathematica/Applications/SimpleDocs/project/docs/content/ref/BuildNotebookDocsSite.nb","Documentation"->"~/Documents/Wolfram Mathematica/Applications/SimpleDocs/Documentation/English/ReferencePages/Symbols/BuildNotebookDocsSite.nb","Markdown"->"~/Documents/Wolfram Mathematica/Applications/SimpleDocs/project/docs/content/ref/BuildNotebookDocsSite.md"|>

Seems clean. Now let's do this for all of the rest of them (where they aren't just objects, which a) don't work well with the templates and b) aren't going to be worth documenting really):

    doTemplateDocs/@
      Select[Rest@needDocs, Length@ToExpression[#, StandardForm, OwnValues]==0&];

---

---

<a id="related-guides" style="width:0;height:0;margin:0;padding:0;">&zwnj;</a>

## Related Guides

* [SimpleDocs](../guide/SimpleDocs.html)

<a id="related-tutorials" style="width:0;height:0;margin:0;padding:0;">&zwnj;</a>

## Related Tutorials

* [SimpleDocs](../tutorial/SimpleDocs.html)

<a id="related-links" style="width:0;height:0;margin:0;padding:0;">&zwnj;</a>

## Related Links

* [SimpleDocs](https://github.com/b3m2a1/SimpleDocs)

* [BTools](https://github.com/b3m2a1/mathematica-BTools)

* [Ems](https://github.com/b3m2a1/Ems)

---

Made with  [SimpleDocs](https://github.com/b3m2a1/SimpleDocs)