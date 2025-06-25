Class {
	#name : #ToTabExamples,
	#superclass : #Object,
	#category : #'Toplo-Widget-TabPaneDeprecated-Examples'
}

{ #category : #'tabPane-dep' }
ToTabExamples class >> example_closeableTabs [

	| nb but |
	nb := ToTabPane new.
	nb 
		newCheckAction: [ :evt :grp :l | l traceCr ]
		onGroup: nb group.
	nb preservePaneOnSelect: false.
	(Color wheel: 5) withIndexDo: [ :eachColor :index |
		but := ToTab new.
		but closable: true.
		but checkAction: [ :evt :target :value | value traceCr ].
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: eachColor ].
		nb addTab: but ].
	nb openInSpace.
	nb inspect
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnBottomCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnBottomCenter.
	nb inspect.
	^ nb
]

{ #category : #misc }
ToTabExamples class >> example_headerOnBottomLeft [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnBottomLeft.
	^ nb
]

{ #category : #tabs }
ToTabExamples class >> example_headerOnBottomResizablePanes [

	| nb |
	nb := self example_headerOnBottomLeft.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnBottomRight [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnBottomRight.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnLeftBottom [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnLeftBottom.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnLeftCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnLeftCenter.
	^ nb
]

{ #category : #tabs }
ToTabExamples class >> example_headerOnLeftResizablePanes [

	| nb |
	nb := self example_headerOnLeftTop.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnLeftTop [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnLeftTop.
	^ nb
]

{ #category : #'vertical labels' }
ToTabExamples class >> example_headerOnLeftTopVerticalLabels [

	| nb but |
	nb := ToTabPane new.
	nb constraintsDo: [ :c | c accountTransformation ].
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but labelText: 'Button ' , index asString.
		but firstChild rotateBy: 270.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	nb header constraintsDo: [ :c | c accountTransformation ].
	nb withHeaderOnLeftTop.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnRightBottom [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnRightBottom.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnRightCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnRightCenter.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnRightTop [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnRightTop.
	^ nb
]

{ #category : #'vertical labels' }
ToTabExamples class >> example_headerOnRightTopLabelsDiagonally [

	| nb but |
	nb := ToTabPane new.
	nb constraintsDo: [ :c | c accountTransformation ].
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but layout beVertical.
		but layout alignCenter.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but firstChild rotateBy: 50.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	nb header constraintsDo: [ :c | c accountTransformation ].
	nb withHeaderOnRightTop.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnTopCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnTopCenter.
	^ nb
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnTopLeft [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnTopLeft.
	^ nb
]

{ #category : #tabs }
ToTabExamples class >> example_headerOnTopResizablePanes [

	| nb |
	nb := self example_tabPane.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : #tabs }
ToTabExamples class >> example_headerOnTopResizablePanesHorizontalBody [

	| nb |
	nb := self example_tabPane.
	nb withoutCheckingStrategy.
	nb withResizablePanes.
	nb withHorizontalBody
]

{ #category : #'header positionning' }
ToTabExamples class >> example_headerOnTopRight [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnTopRight.
	^ nb
]

{ #category : #tabs }
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

{ #category : #tabs }
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

{ #category : #misc }
ToTabExamples class >> example_tabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook |
			pane addChild: (ToSwitchButton new
					 checked: false;
					 yourself) ].
		nb addTab: but ].
	nb openInSpace.
	^ nb
]

{ #category : #'composing tabs' }
ToTabExamples class >> example_tabPaneInTabPane [

	| tabPane tab |
	tabPane := ToTabPane new.
	1 to: 3 do: [ :index |
		tab := ToTab new.
		tab labelText: 'Tab ' , index asString.
		tab paneBuilder: [ :pane :theTabPane |
			pane addChild: self subTabPane withHeaderOnLeftTop ].
		tabPane addTab: tab ].
	tabPane openInSpace
]

{ #category : #'tabPane-dep' }
ToTabExamples class >> example_tabPaneWithCustomSelectionBar [

	| nb |
	nb := self example_tabPane.
	nb tabs do: [ :but |
		but defaultSkin: ToTabWithCustomSelectionBarSkin new ].
	^ nb
]

{ #category : #tabs }
ToTabExamples class >> example_tabPaneWithStartContainer [
	| nb but header |
	nb := ToTabPane new.
	header := nb header.
	header startContainer addChild: ((ToElement new size: 150 asPoint) background: Color red; layout: BlFrameLayout new).
	header startContainer fitContent.
	header startContainer constraintsDo: [ :c |
		c linear vertical alignCenter ].

	header endContainer addChild: ((ToElement new size: 50 asPoint) background: Color red; layout: BlFrameLayout new).
	header endContainer fitContent.
	header endContainer constraintsDo: [ :c |
		c linear vertical alignCenter ].

	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	nb withHeaderOnRightCenter.
	^ nb
]

{ #category : #tabs }
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

{ #category : #tabs }
ToTabExamples class >> example_twoTabsWithListElement [

	| tabsPanel list1 list2 tab1 tab2 |
	list1 := ToListElement new.
	list1 constraints vertical matchParent.
	list1 constraints horizontal matchParent.
	1 to: 10 do: [ :i | list1 dataAccessor add: 'Hello ' , i asString ].
	list2 := ToListElement new.
	list2 constraints vertical matchParent.
	list2 constraints horizontal matchParent.
	11 to: 20 do: [ :i | list2 dataAccessor add: 'Goodbye ' , i asString ].
	tabsPanel := ToTabPane new.
	tab1 := ToTab new.
	tab1 labelText: 'Hello'.
	tab1 paneBuilder: [ :pane :theTabPane | pane addChild: list1 ].
	tab2 := ToTab new.
	tab2 labelText: 'Goodbye'.
	tab2 paneBuilder: [ :pane :theTabPane | pane addChild: list2 ].
	tabsPanel addTab: tab1.
	tabsPanel addTab: tab2.
	tabsPanel openInSpace
]

{ #category : #testing }
ToTabExamples class >> isDeprecated [ 

	^ true
]

{ #category : #'composing tabs' }
ToTabExamples class >> subTabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 3 do: [ :index |
		but := ToTab new.
		but labelText: 'sub tab ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane addChild: self subsubTabPane withHeaderOnRightBottom ].
		nb addTab: but ].
	^ nb
]

{ #category : #'composing tabs' }
ToTabExamples class >> subsubTabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 4 do: [ :index |
		but := ToTab new.
		but labelText: 'sub sub tab ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane addChild: self subsubsubTabPane withHeaderOnBottomLeft ].
		nb addTab: but ].
	^ nb
]

{ #category : #'composing tabs' }
ToTabExamples class >> subsubsubTabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 2 do: [ :index |
		but := ToTab new.
		but labelText: 'sub sub sub tab ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	^ nb
]

{ #category : #'see class side' }
ToTabExamples >> seeClassSide [ 
]
