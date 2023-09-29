Class {
	#name : #ToInnerWindow,
	#superclass : #ToWindowElement,
	#traits : 'TToWidgetWithResizeGrips + TToWidgetWithContextMenu',
	#classTraits : 'TToWidgetWithResizeGrips classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'bar',
		'title',
		'titleLabel',
		'barPullHandler'
	],
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #adding }
ToInnerWindow >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	self
		deprecated: 'Send addChild: to root.'
		transformWith:
			'`@receiver addChild: `@arg'
				-> '`@receiver root addChild: `@arg'.

	self root addChild: anElement
]

{ #category : #accessing }
ToInnerWindow >> bar [

	^ bar ifNil: [ self bar: self defaultBar. bar ]
]

{ #category : #accessing }
ToInnerWindow >> bar: anElement [

	bar ifNotNil: [ 
		bar removeEventHandler: barPullHandler.
		bar removeFromParent ].
	bar := anElement.
	bar addEventHandler: barPullHandler
]

{ #category : #initialization }
ToInnerWindow >> defaultBar [

	| b close expand fill1 fill2 fill3 fill4 |
	b := ToPane horizontal
		     border: BlBorder empty;
			vFitContent;
		     outskirts: BlOutskirts inside;
		     yourself.
	b layout: BlLinearLayout horizontal.
	b when: BlDoubleClickEvent do: [ self maximize ].
	b when: BlMouseDownEvent do: [ self toFront ].
	close := ToButton new icon: (ToImage new innerImage: Smalltalk ui theme windowCloseForm).
	close height: 16.
	close whenClickedDo: [ self close ].
	expand := ToButton new icon: (ToImage new innerImage: Smalltalk ui theme windowMaximizeForm).
	expand whenClickedDo: [ self maximize ].
	expand height: 16.

	fill1 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c |
			         c vertical exact: 1.
			         c horizontal exact: 3 ].
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
			         c horizontal exact: 3 ].
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
ToInnerWindow >> defaultBarBackground [
	
	^ Color veryLightGray alpha: 0.4
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

	^ 3
]

{ #category : #initialization }
ToInnerWindow >> defaultRoot [

	^ super defaultRoot
		  outskirts: BlOutskirts outside;
		  matchParent
]

{ #category : #initialization }
ToInnerWindow >> defaultRootBackground [

	^ Color white
]

{ #category : #initialization }
ToInnerWindow >> defaultRootLayout [

	^ BlBasicLayout uniqueInstance 
]

{ #category : #initialization }
ToInnerWindow >> defaultSize [

	^ 300@200
]

{ #category : #initialization }
ToInnerWindow >> defaultTitle [

	^ ''
]

{ #category : #initialization }
ToInnerWindow >> elements [

	^ { self bar. self root }
]

{ #category : #initialization }
ToInnerWindow >> initialize [ 

	barPullHandler := BlPullHandler new target: self; yourself.
	super initialize.
	self layout: BlLinearLayout vertical.
	self size: self defaultSize.
	self background: Color gray.
	self initializeGrips

]

{ #category : #'api - displaying' }
ToInnerWindow >> maximize [

	self
		position: 0 @ 0;
		size: self parent size
]

{ #category : #'api - displaying' }
ToInnerWindow >> show [
	"Open me in a window and show it to the user"

	self openInSpace
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
