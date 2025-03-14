Trait {
	#name : #TToTripletElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createEndContainer [

	self toploConfiguration checkEndContainer
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createStartContainer [

	self toploConfiguration checkStartContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> defaultTripletEventHandler [

	^ ToTripletElementEventHandler new
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment [

	^ self toploConfiguration endAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment: aNumber [

	self endAlignment = aNumber ifTrue: [ ^ self ].
	self toploConfiguration endAlignment: aNumber.
	self toploConfiguration checkEndContainerIn: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endContainer [

	^ self toploConfiguration endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^ self toploConfiguration endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	self endElement = anElement ifTrue: [ ^ self ].
	self toploConfiguration endElement: anElement in: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElementDo: aBlock [

	self endElement ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFiller [

	^ self toploConfiguration endFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible [

	^ self toploConfiguration endFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible: aBoolean [

	self endFlexible = aBoolean ifTrue: [ ^ self ].
	self toploConfiguration endFlexible: aBoolean.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace [

	^ self toploConfiguration endInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self endInterspace = aNumber ifTrue: [ ^ self ].
	self toploConfiguration endInterspace: aNumber.
	self requestNewConfigurationPass 
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

	^ self toploConfiguration endElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasMiddleElement [

	^ self toploConfiguration middleElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasStartElement [

	^ self toploConfiguration startElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isEndFlexible [

	^ self toploConfiguration endFlexible
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isStartFlexible [

	^ self toploConfiguration startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleContainer [

	^ self toploConfiguration middleContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement [

	^ self toploConfiguration middleElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement: anElement [

	self middleElement = anElement ifTrue: [ ^ self ].
	self toploConfiguration middleElement: anElement in: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newBaseContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  layout: BlFrameLayout new;
		  yourself
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newFiller [

	^ BlElement new
		  size: 0 @ 0;
		  layout: BlLinearLayout new;
		  yourself
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newMiddleContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  layout: BlFrameLayout new;
		  yourself
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment [

	^ self toploConfiguration startAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self toploConfiguration startAlignment: aNumber in: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startContainer [

	^ self toploConfiguration startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ self toploConfiguration startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	anElement = self startElement ifTrue: [ ^ self ].
	self toploConfiguration startElement: anElement in: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFiller [

	^ self toploConfiguration startFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible [

	^ self toploConfiguration startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible: aBoolean [

	self startFlexible = aBoolean ifTrue: [ ^ self ].
	self toploConfiguration startFlexible: aBoolean.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace [

	^ self toploConfiguration startInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace: aNumber [

	self startInterspace = aNumber ifTrue: [ ^ self ].
	self toploConfiguration startInterspace: aNumber.
	self requestNewConfigurationPass 
]
