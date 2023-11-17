Class {
	#name : 'ToNotebookExamples',
	#superclass : 'Object',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'tabs' }
ToNotebookExamples class >> example_closeableTabs [

	| space notebook |
	space := BlSpace new.
	notebook := ToNotebook new.
	notebook inspect.
	space root addChild: notebook.

	(Color wheel: 5) withIndexDo: [ :eachColor :index |
		| aPage |
		aPage := notebook
			addPageEntitled: 'Page ', index asString
			withBody: (BlElement new
				background: eachColor;
				yourself).
		aPage closeable: true ].


	space show
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_tabsWith2Pages [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToNotebook new.

	redCount := 0.
	redPage := aNotebook addPageEntitled: 'Red' withBodyBuilder: [
		           redCount := redCount + 1.
		           BlTextElement new
			           text:
				           (redCount asRopedText foreground: Color red darker);
			           yourself ].

	greenCount := 0.
	greenPage := aNotebook addPageEntitled: 'Green' withBodyBuilder: [
		             greenCount := greenCount + 1.
		             BlTextElement new
			             text:
				             (greenCount asRopedText foreground:
						              Color green muchDarker);
			             yourself ].

	aNotebook openInSpace
]

{ #category : 'see class side' }
ToNotebookExamples >> seeClassSide [ 
]
