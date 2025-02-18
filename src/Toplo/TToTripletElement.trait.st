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

	^ self tripletProperties endAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment: aNumber [

	self endAlignment = aNumber ifTrue: [ ^ self ].
	self tripletProperties endAlignment: aNumber.
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

	^ self tripletProperties endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^ self tripletProperties endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	anElement = self endElement ifTrue: [ ^ self ].
	self endElement ifNotNil: [ :s | s removeFromParent ].
	self tripletProperties endElement: anElement.
	anElement ifNil: [ ^ self ].
	self endContainer addChild: anElement
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

	self endFlexible = aBoolean ifTrue: [ ^ self ].
	self tripletProperties endFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endGap [

	^ self tripletProperties endGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace [

	^ self tripletProperties endInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self tripletProperties endInterspace: aNumber.
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
TToTripletElement >> initializeAsTripletElement [

	self tripletProperties: ToTripletElementProperties new.
	self tripletProperties on: self.

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

	anElement = self middleElement ifTrue: [ ^ self ].
	self middleElement ifNotNil: [ :s | s removeFromParent ].
	self tripletProperties middleElement: anElement.
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

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment [

	^ self tripletProperties startAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self tripletProperties startAlignment: aNumber.
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

	^ self tripletProperties startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ self tripletProperties startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	anElement = self startElement ifTrue: [ ^ self ].
	self startElement ifNotNil: [ :s | s removeFromParent ].
	self tripletProperties startElement: anElement.
	anElement ifNil: [ ^ self ].
	self startContainer addChild: anElement
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

	self startFlexible = aBoolean ifTrue: [ ^ self ].
	self tripletProperties startFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startGap [

	^ self tripletProperties startGap
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

	^ self explicitRequirement 
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> tripletProperties: aTripletProperties [

	^ self explicitRequirement 
]
