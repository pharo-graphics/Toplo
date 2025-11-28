Trait {
	#name : #TToTripletContainer,
	#instVars : [
		'startContainer',
		'middleContainer',
		'endContainer',
		'startFiller',
		'endFiller'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> alignCenter [

	^ self toConfiguration alignCenter
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> alignCenter: aBoolean [

	self alignCenter = aBoolean ifTrue: [ ^ self ].
	self toConfiguration alignCenter: aBoolean.
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> createEndContainer [

	endContainer := self newEndContainer
		                  id: #'end-container';
		                  yourself.
	self addChild: endContainer
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> createMiddleContainer [

	middleContainer ifNotNil: [ ^ self ].
	middleContainer := self newMiddleContainer.
	middleContainer id ifNil: [ middleContainer id: #'middle-container' ].
	self addChild: middleContainer
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> createStartContainer [

	startContainer := self newStartContainer
		                  id: #'start-container';
		                  yourself.
	self addChild: startContainer at: 1
]

{ #category : #'t - triplet container - initialization' }
TToTripletContainer >> defaultTripletEventHandler [

	^ ToTripletContainerEventHandler new
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endAlignment [

	^ self toConfiguration endAlignment
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endAlignment: aNumber [

	self endAlignment = aNumber ifTrue: [ ^ self ].
	self ensureEndContainer.
	self toConfiguration endAlignment: aNumber.
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endChildren [

	^ Array streamContents: [ :stream |
		  endContainer ifNotNil: [ :s | stream nextPut: s ].
		  self endGap ifNotNil: [ :s | stream nextPut: s ].
		  self endFiller ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endContainer [

	^ endContainer
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endFiller [

	^ endFiller
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endFillerBuilder: aBlock [

	self endFlexible: true.
	aBlock value: self endFiller
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endFlexible [

	^ endFiller notNil
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endFlexible: aBoolean [

	aBoolean
		ifTrue: [
				endFiller ifNotNil: [ ^ self ].
				endFiller := self newFiller.
				endFiller id: #'end-filler'.
				endFiller matchParent.
				self addChild: endFiller after: middleContainer ]
		ifFalse: [
				endFiller ifNil: [ ^ self ].
				endFiller removeFromParent.
				endFiller := nil ].
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endGap [

	^ self toConfiguration endGap
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endInterspace [

	^ self toConfiguration endInterspace
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> endInterspace: aNumber [

	self endInterspace = aNumber ifTrue: [ ^ self ].
	self toConfiguration endInterspace: aNumber.
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> ensureEndContainer [

	endContainer ifNotNil: [ ^ self ].
	self createEndContainer


]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> ensureMiddleContainer [ 

	middleContainer ifNotNil: [ ^ self ].
	self createMiddleContainer


]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> ensureStartContainer [ 

	startContainer ifNotNil: [ ^ self ].
	self createStartContainer


]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> flexible [

	^ self startFlexible and: [ self endFlexible ]
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> flexible: aBoolean [

	self startFlexible: aBoolean.
	self endFlexible: aBoolean
]

{ #category : #'t - triplet container - initialization' }
TToTripletContainer >> initializeAsTripletContainer [

	self addEventHandler: self defaultTripletEventHandler
]

{ #category : #'t - triplet container - testing' }
TToTripletContainer >> isEndFlexible [

	^ self endFlexible
]

{ #category : #'t - triplet container - testing' }
TToTripletContainer >> isStartFlexible [

	^ self startFlexible
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> middleChildren [

	^ Array streamContents: [ :stream |
		  middleContainer ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> middleContainer [

	^ middleContainer 
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> newEndContainer [

	^ self newFrameContainer
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> newFiller [

	^ ToElement new
		  withNullSkin;
		  extent: 0 @ 0;
		  layout: BlLinearLayout new;
		  yourself
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> newFrameContainer [

	^ ToElement new
		  withNullSkin;
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

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> newLinearContainer [

	^ ToElement new
		  withNullSkin;
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

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> newMiddleContainer [

	^ self newFrameContainer
]

{ #category : #'t - triplet container - instance creation' }
TToTripletContainer >> newStartContainer [

	^ self newFrameContainer
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startAlignment [

	^ self toConfiguration startAlignment
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startAlignment: aNumber [

	self startAlignment = aNumber ifTrue: [ ^ self ].
	self ensureStartContainer.
	self toConfiguration startAlignment: aNumber.
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startChildren [

	^ Array streamContents: [ :stream |
		  startContainer ifNotNil: [ :s | stream nextPut: s ].
		  self startGap ifNotNil: [ :s | stream nextPut: s ].
		  startFiller ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startContainer [

	^ startContainer
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startFiller [

	^ startFiller
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startFillerBuilder: aBlock [

	self startFlexible: true.
	aBlock value: startFiller
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startFlexible [

	^ startFiller notNil
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startFlexible: aBoolean [

	aBoolean
		ifTrue: [
				startFiller ifNotNil: [ ^ self ].
				startFiller := self newFiller.
				startFiller id: #'start-filler'.
				startFiller matchParent.
				self addChild: startFiller before: middleContainer ]
		ifFalse: [
				startFiller ifNil: [ ^ self ].
				startFiller removeFromParent.
				startFiller := nil ].
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startGap [

	^ self toConfiguration startGap
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startInterspace [

	^ self toConfiguration startInterspace
]

{ #category : #'t - triplet container - accessing' }
TToTripletContainer >> startInterspace: aNumber [

	self startInterspace = aNumber ifTrue: [ ^ self ].
	self toConfiguration startInterspace: aNumber.
	self requestConfiguration.
	self requestNewSkin
]
