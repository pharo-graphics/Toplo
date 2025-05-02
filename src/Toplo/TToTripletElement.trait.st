Trait {
	#name : #TToTripletElement,
	#instVars : [
		'startContainer',
		'middleContainer',
		'endContainer',
		'startElement',
		'middleElement',
		'endElement'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element - testing' }
TToTripletElement >> canHidePart [

	^ self widgetConfiguration canHidePart
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> canHidePart: aBoolean [

	self widgetConfiguration canHidePart: aBoolean
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> checkEndContainer [

	endContainer ifNotNil: [ ^ self ].
	self createEndContainer


]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> checkMiddleContainer [ 

	middleContainer ifNotNil: [ ^ self ].
	self createMiddleContainer


]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> checkStartContainer [ 

	startContainer ifNotNil: [ ^ self ].
	self createStartContainer


]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createEndContainer [

	endContainer := self newFrameContainer
		                  id: #'end-container';
		                  yourself.
	self addChild: endContainer
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createMiddleContainer [

	middleContainer ifNotNil: [ ^ self ].
	middleContainer := self newMiddleContainer.
	middleContainer id: #'middle-container'.
	self addChild: middleContainer
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createStartContainer [

	startContainer := self newFrameContainer
		                  id: #'start-container';
		                  yourself.
	self addChild: startContainer at: 1
]

{ #category : #'t - triplet element - initialization' }
TToTripletElement >> defaultTripletEventHandler [

	^ ToTripletElementEventHandler new
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment [

	^ self widgetConfiguration endAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment: aNumber [

	self endAlignment = aNumber ifTrue: [ ^ self ].
	self checkEndContainer.
	self widgetConfiguration endAlignment: aNumber.
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endChildren [

	^ Array streamContents: [ :stream |
		  endContainer ifNotNil: [ :s | stream nextPut: s ].
		  self endGap ifNotNil: [ :s | stream nextPut: s ].
		  self endFiller ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endContainer [

	^ endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^  endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	endElement = anElement ifTrue: [ ^ self ].
	endElement ifNotNil: [ :s | s removeFromParent ].
	endElement := anElement.
	endElement ifNotNil: [
		self checkEndContainer.
		endContainer addChild: endElement ].
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElementDo: aBlock [

	endElement ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFiller [

	^ self widgetConfiguration endFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible [

	^ self widgetConfiguration endFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible: aBoolean [

	self endFlexible = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration endFlexible: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endGap [

	^ self widgetConfiguration endGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace [

	^ self widgetConfiguration endInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self endInterspace = aNumber ifTrue: [ ^ self ].
	self widgetConfiguration endInterspace: aNumber.
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> flexible [

	^ self startFlexible and: [ self endFlexible ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> flexible: aBoolean [

	self startFlexible: aBoolean.
	self endFlexible: aBoolean
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasEndElement [

	^ endElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasMiddleElement [

	^ middleElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasStartElement [

	^ startElement notNil
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideEnd [

	^ self widgetConfiguration hideEnd
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideEnd: aBoolean [

	self hideEnd = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration hideEnd: aBoolean.
	self requestNewConfiguration

]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideMiddle [

	^ self widgetConfiguration hideMiddle
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideMiddle: aBoolean [

	self hideMiddle = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration hideMiddle: aBoolean.
	self requestNewConfiguration

]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideStart [

	^ self widgetConfiguration hideStart
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideStart: aBoolean [

	self hideStart = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration hideStart: aBoolean.
	self requestNewConfiguration

]

{ #category : #'t - triplet element - initialization' }
TToTripletElement >> initializeAsTripletElement [

	"the midddle container must be created because other parts are added according to its position"
	self createMiddleContainer.
	self addEventHandler: self defaultTripletEventHandler
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isEndFlexible [

	^ self widgetConfiguration endFlexible
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isStartFlexible [

	^ self widgetConfiguration startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleChildren [

	^ Array streamContents: [ :stream |
		  middleContainer ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleContainer [

	^ middleContainer 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement [

	^ middleElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement: anElement [

	middleElement = anElement ifTrue: [ ^ self ].
	middleElement ifNotNil: [ :s | s removeFromParent ].
	middleElement := anElement.
	middleElement ifNotNil: [ middleContainer addChild: middleElement ].
	self requestNewConfiguration
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newFiller [

	^ BlElement new
		  size: 0 @ 0;
		  layout: BlLinearLayout new;
		  yourself
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newFrameContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent.
			  c linear vertical alignCenter.
			  c linear horizontal alignCenter.
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  layout: BlFrameLayout new;
		  yourself
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newLinearContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent.
			  c linear vertical alignCenter.
			  c linear horizontal alignCenter.
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  layout: BlLinearLayout new;
		  yourself
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newMiddleContainer [

	^ self newFrameContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment [

	^ self widgetConfiguration startAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self checkStartContainer.
	self widgetConfiguration startAlignment: aNumber.
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startChildren [

	^ Array streamContents: [ :stream |
		  startContainer ifNotNil: [ :s | stream nextPut: s ].
		  self startGap ifNotNil: [ :s | stream nextPut: s ].
		  self startFiller ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startContainer [

	^ startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	startElement = anElement ifTrue: [ ^ self ].
	startElement ifNotNil: [ :s | s removeFromParent ].
	startElement := anElement.
	startElement ifNotNil: [
		self checkStartContainer.
		startContainer addChild: startElement ].
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFiller [

	^ self widgetConfiguration startFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible [

	^ self widgetConfiguration startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible: aBoolean [

	self startFlexible = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration startFlexible: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startGap [

	^ self widgetConfiguration startGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace [

	^ self widgetConfiguration startInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace: aNumber [

	self startInterspace = aNumber ifTrue: [ ^ self ].
	self widgetConfiguration startInterspace: aNumber.
	self requestNewConfiguration
]
