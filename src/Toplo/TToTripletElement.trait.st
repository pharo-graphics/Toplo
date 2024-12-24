Trait {
	#name : #TToTripletElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element - layout' }
TToTripletElement >> configureLayout [

	self isStartFlexible
		ifTrue: [
			self startFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			self startFiller resizerDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ] ].
	self isEndFlexible
		ifTrue: [
			self endFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			self endFiller resizerDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ] ].
	self isHorizontal
		ifTrue: [
			self childrenDo: [ :child |
				child constraints linear vertical alignCenter ].
			self startGap size = (self startInterspace @ 0) ifFalse: [
				self startGap size: self startInterspace @ 0 ].
			self endGap size = (self endInterspace @ 0) ifFalse: [
				self endGap size: self endInterspace @ 0 ].
			self endElement ifNotNil: [ :ee |
				ee constraints frame horizontal alignRight ] ]
		ifFalse: [
			self childrenDo: [ :child |
				child constraints linear horizontal alignCenter ].
			self startGap size = (0 @ self startInterspace) ifFalse: [
				self startGap size: 0 @ self startInterspace ].
			self endGap size = (0 @ self endInterspace) ifFalse: [
				self endGap size: 0 @ self endInterspace ].
			self endElement ifNotNil: [ :ee |
				ee constraints frame vertical alignBottom ] ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> defaultTripletEventHandler [

	^ ToTripletElementEventHandler new
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment [

	^ self properties endAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment: aNumber [

	self endAlignment = aNumber ifTrue: [ ^ self ].
	self properties endAlignment: aNumber.
	self endAlignment ifNotNil: [
		self isHorizontal
			ifTrue: [
				self endContainer constraintsDo: [ :c |
					c horizontal exact: self endAlignment.
					c vertical fitContent ] ]
			ifFalse: [
				self endContainer constraintsDo: [ :c |
					c vertical exact: self endAlignment.
					c horizontal fitContent ] ] ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endContainer [

	^ self properties endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^ self properties endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	anElement = self endElement ifTrue: [ ^ self ].
	self endElement ifNotNil: [ :s | s removeFromParent ].
	self properties endElement: anElement.
	anElement ifNil: [ ^ self ].
	self endContainer addChild: anElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElementDo: aBlock [

	self endElement ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFiller [

	^ self properties endFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible [

	^ self properties endFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible: aBoolean [

	self endFlexible = aBoolean ifTrue: [ ^ self ].
	self properties endFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endGap [

	^ self properties endGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace [

	^ self properties endInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self properties endInterspace: aNumber.
	self requestLayout
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

	^ self properties endElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasMiddleElement [

	^ self props middleElement notNil
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> hasStartElement [

	^ self props startElement notNil
]

{ #category : #'t - triplet element - initialization' }
TToTripletElement >> initializeTripletElement [

	self properties: ToTripletElementProperties new.
	self properties on: self.

	self addChildren: {
			self startContainer.
			self startGap.
			self startFiller.
			self middleContainer.
			self endFiller.
			self endGap.
			self endContainer }.

	self addEventHandler: self defaultTripletEventHandler.
	self fitContent
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isEndFlexible [

	^ self properties endFlexible
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isStartFlexible [

	^ self properties startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleContainer [

	^ self properties middleContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement [

	^ self properties middleElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement: anElement [

	anElement = self middleElement ifTrue: [ ^ self ].
	self middleElement ifNotNil: [ :s | s removeFromParent ].
	self properties middleElement: anElement.
	anElement ifNil: [ ^ self ].
	self middleContainer addChild: anElement
]

{ #category : #'t - triplet element - instance creation' }
TToTripletElement >> newBaseContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  layout: BlLinearLayout new;
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

	^ ToElement  new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  yourself
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> properties [

	^ self explicitRequirement 
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> properties: aTripletElementProperties [

	self explicitRequirement 
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> props [

	self
		deprecated: 'Please use #properties instead'
		transformWith: '`@receiver props' -> '`@receiver properties'.
	^ self properties
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> props: aTripletElementProperties [

	self
		deprecated: 'Use #properties: instead'
		transformWith:
		'`@receiver props: `@argument'
		-> '`@receiver properties: `@argument'.
	self properties: aTripletElementProperties
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment [

	^ self properties startAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self properties startAlignment: aNumber.
	self startAlignment ifNotNil: [
		self isHorizontal
			ifTrue: [
				self startContainer constraintsDo: [ :c |
					c horizontal exact: self startAlignment.
					c vertical fitContent ] ]
			ifFalse: [
				self startContainer constraintsDo: [ :c |
					c vertical exact: self startAlignment.
					c horizontal fitContent ] ] ]
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startContainer [

	^ self properties startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ self properties startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	anElement = self startElement ifTrue: [ ^ self ].
	self startElement ifNotNil: [ :s | s removeFromParent ].
	self properties startElement: anElement.
	anElement ifNil: [ ^ self ].
	self startContainer addChild: anElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFiller [

	^ self properties startFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible [

	^ self properties startFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible: aBoolean [

	self startFlexible = aBoolean ifTrue: [ ^ self ].
	self properties startFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startGap [

	^ self properties startGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace [

	^ self properties startInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace: aNumber [

	self properties startInterspace: aNumber.
	self requestLayout
]
