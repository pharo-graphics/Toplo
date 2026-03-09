Class {
	#name : #ToInnerWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'paneElement',
		'topBarElement'
	],
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToInnerWindow >> closeButton [ 

	^ topBarElement childWithId: #'close-button' ifNone: [  ]
]

{ #category : #initialization }
ToInnerWindow >> defaultExtent [

	^ 400 @ 300
]

{ #category : #initialization }
ToInnerWindow >> defaultPaneElement [

	^ ToInnerWindowPane new
		  id: #'innerWindow-pane';
		  matchParent;
		  layout: self defaultPaneLayout;
		  yourself
]

{ #category : #initialization }
ToInnerWindow >> defaultPaneLayout [

	^ BlBasicLayout uniqueInstance 
]

{ #category : #initialization }
ToInnerWindow >> defaultTitle [

	^ ''
]

{ #category : #initialization }
ToInnerWindow >> defaultTopBarElement [

	| topBar fill1 fill2 fill3 fill4 closeButton expandButton titleLabel |
	topBar := ToDragHandle new attachTo: self.
	topBar layout: BlLinearLayout horizontal.
	topBar
		id: #'innerWindow-bar';
		hMatchParent;
		vFitContent.
	topBar addEventHandler: (BlEventHandler
			 on: BlDoubleClickEvent
			 do: [ self maximize ]).
	topBar addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ self toFront ]).
	closeButton := ToIconicRemoveButton new
		               id: #'close-button';
		               yourself.
	closeButton clickAction: [ self close ].
	expandButton := ToIconicExpandToFullScreenButton new
		                id: #'expand-button';
		                yourself.
	expandButton clickAction: [ self maximize ].

	fill1 := BlElement new constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 6 ].
	fill2 := BlElement new constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal matchParent ].
	fill3 := BlElement new constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal matchParent ].
	fill4 := BlElement new constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 8 ].
	titleLabel := ToLabel new
		              id: #'title-label';
		              text: self defaultTitle;
		              yourself.
	titleLabel hMatchParent.

	topBar addChildren: {
			fill1.
			closeButton.
			fill2.
			titleLabel.
			fill3.
			expandButton.
			fill4 }.
	topBar childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].
	^ topBar
]

{ #category : #accessing }
ToInnerWindow >> expandButton [ 

	^ topBarElement childWithId: #'expand-button' ifNone: [  ]
]

{ #category : #initialization }
ToInnerWindow >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self extent: self defaultExtent.
	self initializeTopBarElement.
	self initializePaneElement.
	self initializeHandles
]

{ #category : #initialization }
ToInnerWindow >> initializeHandles [

	{
		ToBottomRightResizeHandle.
		ToBottomLeftResizeHandle.
		ToTopRightResizeHandle.
		ToTopLeftResizeHandle.
		ToRightResizeHandle.
		ToLeftResizeHandle.
		ToBottomResizeHandle.
		ToTopResizeHandle } do: [ :eachClass |
		eachClass new attachToParent: self ]
]

{ #category : #initialization }
ToInnerWindow >> initializePaneElement [

	paneElement := self defaultPaneElement.
	self root addChild: paneElement after: topBarElement
]

{ #category : #initialization }
ToInnerWindow >> initializeTopBarElement [

	topBarElement := self defaultTopBarElement.
	self root addChild: topBarElement at: 1
]

{ #category : #skin }
ToInnerWindow >> installRawStyle [

	super installRawStyle.

	self topBarElement
		padding: (BlInsets top: 2 bottom: 1);
		outskirts: BlOutskirts inside;
		border: (	self valueOfTokenNamed: #'color-border')
]

{ #category : #'api - displaying' }
ToInnerWindow >> maximize [

	self
		position: 0 @ 0;
		extent: self parent extent
]

{ #category : #accessing }
ToInnerWindow >> pane [

	^ paneElement
]

{ #category : #accessing }
ToInnerWindow >> title [

	^ self titleLabel text asString
]

{ #category : #accessing }
ToInnerWindow >> title: aString [

	self titleLabel ifNotNil: [ :tl | tl text: aString ]
]

{ #category : #accessing }
ToInnerWindow >> titleLabel [

	^ topBarElement childWithId: #'title-label' ifNone: [  ]
]

{ #category : #accessing }
ToInnerWindow >> topBarElement [

	^ topBarElement 
]
