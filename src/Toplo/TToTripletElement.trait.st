Trait {
	#name : #TToTripletElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element - testing' }
TToTripletElement >> canHidePart [

	^ self widgetConfiguration canHidePart
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> canHidePart: aBoolean [

	self widgetConfiguration canHidePart: aBoolean
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createEndContainer [

	self widgetConfiguration checkEndContainer
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> createStartContainer [

	self widgetConfiguration checkStartContainer
]

{ #category : #'t - triplet element - accessing' }
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
	self widgetConfiguration endAlignment: aNumber.
	self widgetConfiguration checkEndContainerIn: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endContainer [

	^ self widgetConfiguration endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^ self widgetConfiguration endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	self endElement = anElement ifTrue: [ ^ self ].
	self widgetConfiguration endElement: anElement in: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElementDo: aBlock [

	self endElement ifNotNil: [ :ic | aBlock value: ic ]
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
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace [

	^ self widgetConfiguration endInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self endInterspace = aNumber ifTrue: [ ^ self ].
	self widgetConfiguration endInterspace: aNumber.
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

	^ self widgetConfiguration endElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasMiddleElement [

	^ self widgetConfiguration middleElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasStartElement [

	^ self widgetConfiguration startElement notNil
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideEnd [

	^ self widgetConfiguration hideEnd
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideEnd: aBoolean [

	self hideEnd = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration hideEnd: aBoolean.
	self requestNewConfigurationPass 

]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideMiddle [

	^ self widgetConfiguration hideMiddle
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideMiddle: aBoolean [

	self hideMiddle = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration hideMiddle: aBoolean.
	self requestNewConfigurationPass 

]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideStart [

	^ self widgetConfiguration hideStart
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> hideStart: aBoolean [

	self hideStart = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration hideStart: aBoolean.
	self requestNewConfigurationPass 

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
TToTripletElement >> middleContainer [

	^ self widgetConfiguration middleContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement [

	^ self widgetConfiguration middleElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement: anElement [

	self middleElement = anElement ifTrue: [ ^ self ].
	self widgetConfiguration middleElement: anElement in: self.
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

	^ self widgetConfiguration startAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self widgetConfiguration startAlignment: aNumber in: self.
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startContainer [

	^ self widgetConfiguration startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ self widgetConfiguration startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	anElement = self startElement ifTrue: [ ^ self ].
	self widgetConfiguration startElement: anElement in: self.
	self requestNewConfigurationPass 
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
	self requestNewConfigurationPass 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace [

	^ self widgetConfiguration startInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace: aNumber [

	self startInterspace = aNumber ifTrue: [ ^ self ].
	self widgetConfiguration startInterspace: aNumber.
	self requestNewConfigurationPass 
]
