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
	nb preservePaneOnSelect: false.
	(Color wheel: 5) withIndexDo: [ :eachColor :index |
		but := ToNotebookButton new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: eachColor ].
		nb addButton: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnBottom [

	| nb |
	nb := self example_notebook.
	nb withHeaderOnBottom.
	^ nb
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnBottomResizablePanes [

	| nb |
	nb := self example_headerOnBottom.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnLeft [

	| nb |
	nb := self example_notebook.
	nb withHeaderOnLeft.
	^ nb
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnLeftResizablePanes [

	| nb |
	nb := self example_headerOnLeft.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnRight [

	| nb |
	nb := self example_notebook.
	nb withHeaderOnRight.
	^ nb
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnTopResizablePanes [

	| nb |
	nb := self example_notebook.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_headerOnTopResizablePanesHorizontalBody [

	| nb |
	nb := self example_notebook.
	nb withoutCheckingStrategy.
	nb withResizablePanes.
	nb withHorizontalBody
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_notPreservingPane [

	| nb but |
	nb := ToNotebook new.
	nb withoutCheckingStrategy.
	nb withHorizontalBody.
	nb preservePaneOnSelect: false.
	1 to: 5 do: [ :index |
		but := ToNotebookButton new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addButton: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_notebook [

	| nb but |
	nb := ToNotebook new.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToNotebookButton new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addButton: but ].
	nb openInSpace.
	^ nb
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_preservingPane [

	| nb but |
	nb := ToNotebook new.
	nb preservePaneOnSelect: true.
	nb withoutCheckingStrategy.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToNotebookButton new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addButton: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToNotebookExamples class >> example_tabsWith2Pages [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToNotebook new.
	aNotebook rebuildPaneOnSelect: true.

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
