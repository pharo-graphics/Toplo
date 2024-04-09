Class {
	#name : #ToLabeledIcon,
	#superclass : #ToTripletElement,
	#category : #'Toplo-Core'
}

{ #category : #configurating }
ToLabeledIcon >> beEndToStart [

	self isEndToStart ifTrue: [ ^ self ].
	self leftToRight: false.
	self requestLayout
]

{ #category : #configurating }
ToLabeledIcon >> beStartToEnd [

	self isStartToEnd ifTrue: [ ^ self ].
	self leftToRight: true.
	self requestLayout
]

{ #category : #initialization }
ToLabeledIcon >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : #accessing }
ToLabeledIcon >> endContainerHeight [

	^ self endContainer requestedHeight
]

{ #category : #accessing }
ToLabeledIcon >> endIcon [

	^ self endElement
]

{ #category : #accessing }
ToLabeledIcon >> endIcon: anElement [

	self endElement: anElement
]

{ #category : #accessing }
ToLabeledIcon >> endInterspace [

	| fc |
	fc := self endFiller constraints.
	^ fc minWidth @ fc minHeight
]

{ #category : #accessing }
ToLabeledIcon >> endInterspace: aPoint [

	| size |
	size := aPoint asPoint.
	self endInterspace = size ifTrue: [ ^ self ].
	self endFiller constraints
		minWidth: size x;
		minHeight: size y.
	self endFiller requestLayout
]

{ #category : #configurating }
ToLabeledIcon >> endToStart: aBoolean [

	self startToEnd: aBoolean not
]

{ #category : #testing }
ToLabeledIcon >> hasEndIcon [

	^ self endIcon notNil
]

{ #category : #testing }
ToLabeledIcon >> hasIcon [

	^ self icon notNil
]

{ #category : #testing }
ToLabeledIcon >> hasLabel [

	^ self label notNil
]

{ #category : #accessing }
ToLabeledIcon >> icon [

	^ self startElement
]

{ #category : #accessing }
ToLabeledIcon >> icon: anElement [

	self startElement: anElement
]

{ #category : #accessing }
ToLabeledIcon >> iconContainer [

	^ self startContainer
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerHeight [

	^ self iconContainer requestedHeight
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerHeight: anInteger [

	self iconContainer height: anInteger
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerWidth [

	^ self iconContainer requestedWidth
]

{ #category : #accessing }
ToLabeledIcon >> iconContainerWidth: anInteger [

	self iconContainer width: anInteger
]

{ #category : #accessing }
ToLabeledIcon >> iconImage [

	^ self icon ifNotNil: [:ic | ic innerImage ]
]

{ #category : #accessing }
ToLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : #testing }
ToLabeledIcon >> isEndToStart [

	^ self isStartToEnd not
]

{ #category : #testing }
ToLabeledIcon >> isStartToEnd [

	^ self isLeftToRight
]

{ #category : #accessing }
ToLabeledIcon >> label [

	^ self middleElement
]

{ #category : #accessing }
ToLabeledIcon >> label: anElement [

	self middleElement: anElement
]

{ #category : #accessing }
ToLabeledIcon >> labelContainer [

	^ self middleContainer
]

{ #category : #accessing }
ToLabeledIcon >> labelText [

	self hasLabel ifFalse: [ ^ nil ].
	^ self label text asString
]

{ #category : #accessing }
ToLabeledIcon >> labelText: aText [

	aText ifNil: [
		self label: nil.
		^ self ].
	self label: (ToLabel text: aText asRopedText).
]

{ #category : #accessing }
ToLabeledIcon >> startInterspace [

	| fc |
	fc := self startFiller constraints.
	^ fc minWidth @ fc minHeight
]

{ #category : #accessing }
ToLabeledIcon >> startInterspace: aPoint [

	| size |
	size := aPoint asPoint.
	self startInterspace = size ifTrue: [ ^ self ].
	self startFiller constraints
		minWidth: size x;
		minHeight: size y.
	self startFiller requestLayout
]

{ #category : #configurating }
ToLabeledIcon >> startToEnd: aBoolean [

	aBoolean
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ]
]
