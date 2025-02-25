Trait {
	#name : #TToTripletElement,
	#instVars : [
		'tripletProperties'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element - configuration' }
TToTripletElement >> applyInnerConfiguration [ 

	self tripletProperties ifNotNil: [:tp | tp applyInnerConfiguration ].
	super applyInnerConfiguration
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> defaultTripletEventHandler [

	^ ToTripletElementEventHandler new
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment: aNumber [

	self tripletProperties endAlignment: aNumber
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endContainer [

	^ self tripletProperties endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^ self tripletProperties endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	self tripletProperties endElement: anElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElementDo: aBlock [

	self endElement ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFiller [

	^ self tripletProperties endFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible [

	^ self tripletProperties endFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible: aBoolean [

	self tripletProperties endFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self tripletProperties endInterspace: aNumber
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

	^ self tripletProperties endElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasMiddleElement [

	^ self tripletProperties middleElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasStartElement [

	^ self tripletProperties startElement notNil
]

{ #category : #'t - triplet element - initialization' }
TToTripletElement >> initializeAsTripletElementOn: anElement [

	anElement == self
		ifTrue: [ self tripletProperties: ToTripletElementProperties new ]
		ifFalse: [
			self tripletProperties: anElement tripletProperties.
			^ self ].

	self tripletProperties on: self
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isEndFlexible [

	^ self tripletProperties endFlexible
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isStartFlexible [

	^ self tripletProperties startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleContainer [

	^ self tripletProperties middleContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement [

	^ self tripletProperties middleElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement: anElement [

	self tripletProperties middleElement: anElement
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

	^ ToElement new
		  withNullSkin;
		  size: 0 @ 0;
		  layout: BlLinearLayout new;
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  yourself
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newMiddleContainer [

	^ ToElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  layout: BlFrameLayout new;
		  yourself
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment [

	^ self tripletProperties startAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self tripletProperties startAlignment: aNumber
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startContainer [

	^ self tripletProperties startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ self tripletProperties startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	self tripletProperties startElement: anElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFiller [

	^ self tripletProperties startFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible [

	^ self tripletProperties startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible: aBoolean [

	self tripletProperties startFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace [

	^ self tripletProperties startInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace: aNumber [

	self tripletProperties startInterspace: aNumber.
	self requestLayout
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> tripletProperties [

	^ tripletProperties
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> tripletProperties: aTripletProperties [

	tripletProperties ifNotNil: [
		(BlImmutableObjectChangeError object: self) signal ].
	tripletProperties := aTripletProperties
]
