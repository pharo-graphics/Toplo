Class {
	#name : #ToInnerWindow,
	#superclass : #ToAbstractWindowElement,
	#traits : 'TToElementWithResizeGrips',
	#classTraits : 'TToElementWithResizeGrips classTrait',
	#instVars : [
		'title',
		'titleLabel',
		'barPullHandler',
		'paneElement',
		'barElement'
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

{ #category : #initialization }
ToInnerWindow >> defaultBarBackground [
	
	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToInnerWindow >> defaultBarElement [

	| b close expand fill1 fill2 fill3 fill4 |
	b := ToPane horizontal
		     border: BlBorder empty;
		     vFitContent;
		     padding: (BlInsets top: 2 bottom: 3);
		     outskirts: BlOutskirts inside;
		     yourself.
	b when: BlDoubleClickEvent do: [ self maximize ].
	b when: BlMouseDownEvent do: [ self toFront ].
	close := ToButton new icon:
		         (ToImage new innerImage: Smalltalk ui theme windowCloseForm).
	close size: 18@18.
	close whenClickedDo: [ self close ].
	expand := ToButton new icon:
		          (ToImage new innerImage:
			           Smalltalk ui theme windowMaximizeForm).
	expand whenClickedDo: [ self maximize ].
	expand size: 18@18.

	fill1 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 6 ].
	fill2 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal matchParent ].
	fill3 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal matchParent ].
	fill4 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 8 ].
	titleLabel := ToLabel new text: self title.
	titleLabel hMatchParent.

	b addChildren: {
			fill1.
			close.
			fill2.
			titleLabel.
			fill3.
			expand.
			fill4 }.
	^ b
]

{ #category : #initialization }
ToInnerWindow >> defaultBorder [

	^ BlBorder paint: self defaultBorderPaint width: self defaultBorderWidth
]

{ #category : #initialization }
ToInnerWindow >> defaultBorderPaint [

	^ Color veryLightGray alpha: 0.8
]

{ #category : #initialization }
ToInnerWindow >> defaultBorderWidth [

	^ 2
]

{ #category : #initialization }
ToInnerWindow >> defaultPaneBackground [

	^ Color white
]

{ #category : #initialization }
ToInnerWindow >> defaultPaneElement [

	^ ToInnerWindowPane new
		  matchParent;
		  background: self defaultPaneBackground;
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

{ #category : #initialization }
ToInnerWindow >> initialize [ 

	super initialize.
	self layout: BlLinearLayout vertical.
	self size: self defaultSize.
	self background: Color lightGray.
	self initializeGrips

]

{ #category : #initialization }
ToInnerWindow >> initializeRootElement [

	super initializeRootElement.
	self bar: self defaultBarElement.
	self pane: self defaultPaneElement	
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
