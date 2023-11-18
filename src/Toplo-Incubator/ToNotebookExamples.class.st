Class {
	#name : 'ToNotebookExamples',
	#superclass : 'Object',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'tabs' }
ToNotebookExamples class >> example_closeableTabs [

	| nb but |
	nb := ToNotebook new.
	(Color wheel: 5) withIndexDo: [ :eachColor :index |
		but := ToNotebookButton new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: eachColor ].
		nb addButton: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_tabsWith2Pages [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToNotebook new.

	redCount := 0.
	redPage := aNotebook
		           addButtonWithText: 'RED'
		           withPaneBuilder: [ :pane :theNotebook |
			           redCount := redCount + 1.
			           pane addChild: (ToLabel
					            text:
						            (redCount asRopedText foreground: Color red darker)) ].

	greenCount := 0.
	greenPage := aNotebook
		             addButtonWithText: 'GREEN'
		             withPaneBuilder: [ :pane :theNotebook |
			             greenCount := greenCount + 1.
			             pane addChild: (ToLabel
					              text:
						              (greenCount asRopedText foreground:
								               Color green darker) ) ].

	aNotebook openInSpace
]

{ #category : 'see class side' }
ToNotebookExamples >> seeClassSide [ 
]
