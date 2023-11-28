Class {
	#name : 'ToTabExamples',
	#superclass : 'Object',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'tabs' }
ToTabExamples class >> example_closeableTabs [

	| nb but |
	nb := ToTabPane new.
	nb group when: ToCheckableGroupChangedEvent do: [ :event | event traceCr ].
	nb preservePaneOnSelect: false.
	(Color wheel: 5) withIndexDo: [ :eachColor :index |
		but := ToTab new.
		but closable: true.
		but when: ToCheckableCheckEvent do: [ :event | event current traceCr ].
		
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: eachColor ].
		nb addTab: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnBottom [

	| nb |
	nb := self example_notebook.
	nb withHeaderOnBottom.
	^ nb
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnBottomResizablePanes [

	| nb |
	nb := self example_headerOnBottom.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnLeft [

	| nb |
	nb := self example_notebook.
	nb withHeaderOnLeft.
	^ nb
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnLeftResizablePanes [

	| nb |
	nb := self example_headerOnLeft.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnRight [

	| nb |
	nb := self example_notebook.
	nb withHeaderOnRight.
	^ nb
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnTopResizablePanes [

	| nb |
	nb := self example_notebook.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : 'tabs' }
ToTabExamples class >> example_headerOnTopResizablePanesHorizontalBody [

	| nb |
	nb := self example_notebook.
	nb withoutCheckingStrategy.
	nb withResizablePanes.
	nb withHorizontalBody
]

{ #category : 'tabs' }
ToTabExamples class >> example_notPreservingPane [

	| nb but |
	nb := ToTabPane new.
	nb withoutCheckingStrategy.
	nb withHorizontalBody.
	nb preservePaneOnSelect: false.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToTabExamples class >> example_notebook [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	^ nb
]

{ #category : 'tabs' }
ToTabExamples class >> example_preservingPane [

	| nb but |
	nb := ToTabPane new.
	nb preservePaneOnSelect: true.
	nb withoutCheckingStrategy.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace
]

{ #category : 'tabs' }
ToTabExamples class >> example_tabsWith2Pages [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToTabPane new.
	aNotebook rebuildPaneOnSelect: true.

	redCount := 0.
	redPage := aNotebook
		           addTabWithText: 'RED'
		           builder: [ :pane :theNotebook |
			           redCount := redCount + 1.
			           pane addChild: (ToLabel
					            text:
						            (redCount asRopedText foreground: Color red darker)) ].

	greenCount := 0.
	greenPage := aNotebook
		             addTabWithText: 'GREEN'
		             builder: [ :pane :theNotebook |
			             greenCount := greenCount + 1.
			             pane addChild: (ToLabel
					              text:
						              (greenCount asRopedText foreground:
								               Color green darker) ) ].

	aNotebook openInSpace
]

{ #category : 'see class side' }
ToTabExamples >> seeClassSide [ 
]
