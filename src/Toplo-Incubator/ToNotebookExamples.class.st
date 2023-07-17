Class {
	#name : #ToNotebookExamples,
	#superclass : #Object,
	#category : #'Toplo-Incubator'
}

{ #category : #tabs }
ToNotebookExamples class >> example_tabsWith2Pages [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToNotebook new.

	redCount := 0.
	redPage := aNotebook addPageTitle: 'Red' bodyFactory: [
		           redCount := redCount + 1.
		           BlTextElement new
			           text:
				           (redCount asRopedText foreground: Color red darker);
			           yourself ].

	greenCount := 0.
	greenPage := aNotebook addPageTitle: 'Green' bodyFactory: [
		             greenCount := greenCount + 1.
		             BlTextElement new
			             text:
				             (greenCount asRopedText foreground:
						              Color green muchDarker);
			             yourself ].

	aNotebook openInSpace
]

{ #category : #'see class side' }
ToNotebookExamples >> seeClassSide [ 
]
