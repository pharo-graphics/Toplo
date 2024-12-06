Class {
	#name : #ToInnerWindow,
	#superclass : #ToBasicWindowElement,
	#traits : 'TToElementWithResizeGrips',
	#classTraits : 'TToElementWithResizeGrips classTrait',
	#instVars : [
		'title',
		'titleLabel',
		'barPullHandler',
		'paneElement',
		'barElement',
		'closeButton',
		'expandButton'
	],
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToInnerWindow >> bar [

	^ barElement 
]

{ #category : #accessing }
ToInnerWindow >> bar: anElement [

	barElement ifNotNil: [
		barElement removeEventHandler: barPullHandler.
		barElement removeFromParent ].
	barPullHandler ifNil: [ barPullHandler := self newBarPullHandler ].
	barElement := anElement.
	barElement ifNotNil: [ :be |
		be addEventHandler: barPullHandler.
		self root addChild: be at: 1 ]
]

{ #category : #accessing }
ToInnerWindow >> closeButton [ 

	^ closeButton 
]

{ #category : #initialization }
ToInnerWindow >> defaultBarElement [

	| b fill1 fill2 fill3 fill4 |
	b := ToPane horizontal
		     vFitContent;
		     yourself.
	b addEventHandler: (BlEventHandler
			 on: BlDoubleClickEvent
			 do: [ self maximize ]).
	b addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ self toFront ]).
	closeButton := ToButton new
		               id: #'close-button';
		               yourself.
	closeButton whenClickedDo: [ self close ].
	closeButton withNullSkin.
	closeButton border: (Color red alpha: 0.3).
	expandButton := ToButton new
		                id: #'expand-button';
		                yourself.
	expandButton whenClickedDo: [ self maximize ].
	expandButton withNullSkin.

	fill1 := BlElement new
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 6 ].
	fill2 := BlElement new
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal matchParent ].
	fill3 := BlElement new
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal matchParent ].
	fill4 := BlElement new
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 8 ].
	titleLabel := ToLabel new text: self title.
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
		  matchParent;
		  layout: self defaultPaneLayout;
		  yourself
]

{ #category : #initialization }
ToInnerWindow >> defaultPaneLayout [

	^ BlBasicLayout uniqueInstance 
]

{ #category : #initialization }
ToInnerWindow >> defaultRootElement [

	^ super defaultRootElement
		  matchParent
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

	^ expandButton 
]

{ #category : #initialization }
ToInnerWindow >> initialize [ 

	super initialize.
	self layout: BlLinearLayout vertical.
	self size: self defaultSize.
	self initializeGrips.
	self grips do: [ :g | g elevation: self defaultElevation ]

]

{ #category : #initialization }
ToInnerWindow >> initializeRootElement [

	super initializeRootElement.
	self bar: self defaultBarElement.
	self pane: self defaultPaneElement	
]

{ #category : #skin }
ToInnerWindow >> installRawStyle [

	super installRawStyle.

	self bar
		padding: (BlInsets top: 2 bottom: 1);
		outskirts: BlOutskirts inside;
		border: (	self valueOfTokenNamed: #'color-border').
	self closeButton icon: (ToImage inner: (self iconNamed: #windowClose)).
	self expandButton icon: (ToImage inner: (self iconNamed: #windowMaximize)).

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
ToInnerWindow >> pane: anElement [

	paneElement ifNotNil: [ :pe | pe removeFromParent ].
	paneElement := anElement.
	paneElement ifNotNil: [ :pe |
		self bar
			ifNil: [ self root addChild: pe ]
			ifNotNil: [ :b | self root addChild: pe after: b ] ]
]

{ #category : #accessing }
ToInnerWindow >> title [

	^ title ifNil: [ title := self defaultTitle ]
]

{ #category : #accessing }
ToInnerWindow >> title: aString [

	title := aString.
	titleLabel ifNotNil: [ titleLabel text: aString ]
]
