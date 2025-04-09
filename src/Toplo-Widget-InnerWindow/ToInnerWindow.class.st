Class {
	#name : #ToInnerWindow,
	#superclass : #ToBasicWindowElement,
	#traits : 'TToElementWithResizeGrips',
	#classTraits : 'TToElementWithResizeGrips classTrait',
	#instVars : [
		'paneElement',
		'barElement'
	],
	#category : #'Toplo-Widget-InnerWindow-Core'
}

{ #category : #accessing }
ToInnerWindow >> bar [

	^ barElement 
]

{ #category : #accessing }
ToInnerWindow >> closeButton [ 

	^ barElement childWithId: #'close-button' ifNone: [  ]
]

{ #category : #initialization }
ToInnerWindow >> defaultBarElement [

	| b fill1 fill2 fill3 fill4 closeButton expandButton titleLabel |
	b := ToPane horizontal
		     id: #'innerWindow-bar';
		     vFitContent;
		     yourself.
	b addEventHandler: (BlEventHandler
			 on: BlDoubleClickEvent
			 do: [ self maximize ]).
	b addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ self toFront ]).
	closeButton := ToIconicRemoveButton new
		               id: #'close-button';
		               yourself.
	closeButton newClickAction: [ self close ].
	expandButton := ToIconicExpandToFullScreenButton new
		                id: #'expand-button';
		                yourself.
	expandButton newClickAction: [ self maximize ].

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

	b addChildren: {
			fill1.
			closeButton.
			fill2.
			titleLabel.
			fill3.
			expandButton.
			fill4 }.
	b childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].
	^ b
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
ToInnerWindow >> defaultSize [

	^ 400@300
]

{ #category : #initialization }
ToInnerWindow >> defaultTitle [

	^ ''
]

{ #category : #accessing }
ToInnerWindow >> expandButton [ 

	^ barElement childWithId: #'expand-button' ifNone: [  ]
]

{ #category : #initialization }
ToInnerWindow >> initialize [ 

	super initialize.
	self layout: BlLinearLayout vertical.
	self size: self defaultSize.
	self initializeBarElement.
	self initializePaneElement.
	self initializeGrips.

]

{ #category : #accessing }
ToInnerWindow >> initializeBarElement [

	barElement := self defaultBarElement.
	barElement addEventHandler: self newBarPullHandler.
	self root addChild: barElement at: 1
]

{ #category : #accessing }
ToInnerWindow >> initializePaneElement [

	paneElement := self defaultPaneElement.
	self root addChild: paneElement after: barElement
]

{ #category : #skin }
ToInnerWindow >> installRawStyle [

	super installRawStyle.

	self bar
		padding: (BlInsets top: 2 bottom: 1);
		outskirts: BlOutskirts inside;
		border: (	self valueOfTokenNamed: #'color-border')
]

{ #category : #'api - displaying' }
ToInnerWindow >> maximize [

	self
		position: 0 @ 0;
		size: self parent size
]

{ #category : #initialization }
ToInnerWindow >> newBarPullHandler [

	^ BlPullHandler new
		  target: self;
		  yourself
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

	^ barElement childWithId: #'title-label' ifNone: [  ]
]
