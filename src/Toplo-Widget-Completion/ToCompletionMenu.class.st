Class {
	#name : #ToCompletionMenu,
	#superclass : #ToElement,
	#instVars : [
		'engine',
		'context',
		'firstVisible',
		'selected',
		'listElement',
		'messageElement',
		'arrowUp',
		'arrowDown',
		'detailElement'
	],
	#category : #'Toplo-Widget-Completion'
}

{ #category : #'instance creation' }
ToCompletionMenu class >> engine: aCompletionEngine position: aPoint [
	^ self new engine: aCompletionEngine position: aPoint
]

{ #category : #drawing }
ToCompletionMenu class >> messageFont [

	"not used yet but could be if we want to specify the font of the title where it's originally used in the NECMenuMorph"
	^ StandardFonts menuFont
]

{ #category : #'instance creation' }
ToCompletionMenu >> engine: aCompletionEngine position: aPoint [

	engine := aCompletionEngine.
	context := engine context.
	self position: aPoint - (20 @ 0).
	self refreshSelection.
   engine space root addChild: self.
]

{ #category : #initialization }
ToCompletionMenu >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c | c horizontal exact: 250.
		c vertical fitContent ].
"	self background: Color veryLightGray."
	self initializeScrollBar. 
	self initializeListAndMessageElement.
]

{ #category : #initialization }
ToCompletionMenu >> initializeListAndMessageElement [

	| container |
	container := ToElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c |
				             c vertical fitContent.
				             c horizontal matchParent ].

	self initializeListElement.

	self initializeMessageElement.

	container addChildren: {
			listElement.
			messageElement }.

	self addChild: container
]

{ #category : #initialization }
ToCompletionMenu >> initializeListElement [

	listElement := ToListElement new nodeBuilder: [ :node :dataItem :holder |
			               | lab |
			               lab := ToLabel new
				                      text: dataItem name;
				                      yourself.
			               node addChild: (ToLabeledIcon new
					                label: lab;
					                startInterspace: 10;
					                hMatchParent) ].


	listElement dataAccessor addAll:
		((1 to: 12) collect: [ :i | Object subclasses at: i ]).

	listElement dataAccessor collection size >= 10
		ifTrue: [ 
			listElement constraintsDo: [ :c | c vertical exact: 225 ] ]
		ifFalse: [
			listElement constraintsDo: [ :c | c vertical fitContent ] ].

	listElement requestFocus
]

{ #category : #initialization }
ToCompletionMenu >> initializeListElement2 [

	listElement := ToElement new
		               constraintsDo: [ :c |
				               c vertical fitContent.
				               c horizontal matchParent ];
		               layout: BlLinearLayout vertical.

	1 to: 10 do: [ :i |
			| elt |
			elt := ToLabel new
				       padding: (BlInsets left: 5);
				       constraintsDo: [ :c |
						       c vertical exact: 20.
						       c horizontal matchParent ];
				       text: 'Test' asRopedText.
			listElement addChild: elt ]
]

{ #category : #initialization }
ToCompletionMenu >> initializeMessageElement [

	messageElement := ToLabel new
		                  "background: Color veryLightGray;"
		                  padding: (BlInsets left: 5);
		                  constraintsDo: [ :c |
				                  c vertical exact: 20.
				                  c horizontal matchParent ];
		                  border: (BlBorder paint: Color lightGray width: 1).

	messageElement text: 'No entries' asRopedText
]

{ #category : #initialization }
ToCompletionMenu >> initializeScrollBar [

	| container |
	container := ToElement new
		             "background: Color veryLightGray;"
		             extent: 20 @ 100;
						padding: (BlInsets all: 5);
		             constraintsDo: [ :c | c vertical matchParent ];
		             layout: BlFrameLayout new;
		             border: (BlBorder paint: Color lightGray width: 1).

	arrowUp := ToElement new
		           background: Color black;
		           extent: 10 asPoint;
		           geometry: BlTriangleGeometry new beTop;
		           constraintsDo: [ :c |
				           c frame vertical alignTop.
				           c frame horizontal alignCenter ].

	arrowDown := ToElement new
		             background: Color black;
		             extent: 10 asPoint;
		             geometry: BlTriangleGeometry new beBottom;
		             constraintsDo: [ :c |
				             c frame vertical alignBottom.
				             c frame horizontal alignCenter ].

	container addChildren: {
			arrowUp.
			arrowDown }.

	self addChild: container
]

{ #category : #private }
ToCompletionMenu >> itemsCount [
	^context entryCount
]

{ #category : #'instance creation' }
ToCompletionMenu >> newRawSkin [ 

	^ ToCompletionMenuSkin new
]

{ #category : #actions }
ToCompletionMenu >> refreshSelection [

	self selected: 0.
	firstVisible := 1.
	context hasEntries ifTrue: [ self selected: 1 ].
	"self show."
	^ true
]

{ #category : #accessing }
ToCompletionMenu >> selected: aNumber [
	"Set the value of selected"
	context hasEntries ifTrue:
		[ ((1 to: self itemsCount) includes: aNumber) ifTrue: [ aNumber ~= selected ifTrue: [ selected := aNumber ] ] ]
]

{ #category : #actions }
ToCompletionMenu >> showDetail [
	"we need to create and display the detail widget before uncommenting this"

	"detailElement ifNotNil: [ ^ self browse ].
	self itemsCount isZero ifTrue: [ ^ self ].
	detailElement := ToCompletionDetail new.
	self updateDetail."

]
