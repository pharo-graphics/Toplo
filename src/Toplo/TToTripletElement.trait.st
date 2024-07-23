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
			self startGap size = (self startInterspace @ 0) ifFalse: [
				self startGap size: self startInterspace @ 0 ].
			self endGap size = (self endInterspace @ 0) ifFalse: [
				self endGap size: self endInterspace @ 0 ].
			self endElement ifNotNil: [ :ee |
				ee constraints frame horizontal alignRight ] ]
		ifFalse: [
			self startGap size = (0 @ self startInterspace) ifFalse: [
				self startGap size: 0 @ self startInterspace ].
			self endGap size = (0 @ self endInterspace) ifFalse: [
				self endGap size: 0 @ self endInterspace ].
			self endElement ifNotNil: [ :ee |
				ee constraints frame vertical alignBottom ] ].

]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> defaultEventHandler [

	^ ToTripletElementEventHandler new
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment [

	^ self props endAlignment
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endAlignment: aNumber [

	self endAlignment = aNumber ifTrue: [ ^ self ].
	self props endAlignment: aNumber.
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

	^ self props endContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement [

	^ self props endElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElement: anElement [

	anElement = self endElement ifTrue: [ ^ self ].
	self endElement ifNotNil: [ :s | s removeFromParent].
	self props endElement: anElement.
	anElement ifNil: [ ^ self ].
	self endContainer addChild: anElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFiller [

	^ self props endFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible [

	^ self props endFlexible
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endFlexible: aBoolean [

	self endFlexible = aBoolean ifTrue: [ ^ self ].
	self props endFlexible: aBoolean
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endGap [

	^ self props endGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace [

	^ self props endInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endInterspace: aNumber [

	self props endInterspace: aNumber.
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

	^ self props endElement notNil
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

	self props: ToTripletElementProperties new.
	self props on: self.

	self addChildren: {
			self startContainer.
			self startGap.
			self startFiller.
			self middleContainer.
			self endFiller.
			self endGap.
			self endContainer }.

	self addEventHandler: self defaultEventHandler.
	self fitContent
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isEndFlexible [

	^ self props endFlexible 
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #'t - triplet element - testing' }
TToTripletElement >> isStartFlexible [

	^ self props startFlexible 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleContainer [

	^ self props middleContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement [

	^ self props middleElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElement: anElement [

	anElement = self middleElement ifTrue: [ ^ self ].
	self middleElement ifNotNil: [ :s | s removeFromParent].
	self props middleElement: anElement.
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
TToTripletElement >> props [

	^ self explicitRequirement 
]

{ #category : #'t - triplet element - private - accessing' }
TToTripletElement >> props: aTripletElementProperties [

	self explicitRequirement 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment [

	^ self props startAlignment 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self props startAlignment: aNumber.
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

	^ self props startContainer
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement [

	^ self props startElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElement: anElement [

	anElement = self startElement ifTrue: [ ^ self ].
	self startElement ifNotNil: [ :s | s removeFromParent ].
	self props startElement: anElement.
	anElement ifNil: [ ^ self ].
	self startContainer addChild: anElement
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFiller [

	^ self props startFiller
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible [

	^ self props startFlexible 
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startFlexible: aBoolean [

	self startFlexible = aBoolean ifTrue: [ ^ self ].
	self props startFlexible: aBoolean.
	
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startGap [

	^ self props startGap
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace [

	^ self props startInterspace
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startInterspace: aNumber [

	self props startInterspace: aNumber.
	self requestLayout
]
