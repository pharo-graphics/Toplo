Trait {
	#name : #TToTripletElement,
	#instVars : [
		'startElement',
		'middleElement',
		'endElement'
	],
	#category : #'Toplo-Core'
}

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
		self ensureEndContainer.
		self endContainer addChild: endElement ].
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> endElementDo: aBlock [

	endElement ifNotNil: [ :ic | aBlock value: ic ]
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

{ #category : #'t - triplet element - initialization' }
TToTripletElement >> initializeAsTripletElement [

	self initializeAsTripletContainer.
	"the midddle container must be created because other parts are added according to its position"
	self createMiddleContainer.


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
	middleElement ifNotNil: [ self middleContainer addChild: middleElement ].
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> middleElementDo: aBlock [

	middleElement ifNotNil: [ :ic | aBlock value: ic ]
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
		self ensureStartContainer.
		self startContainer addChild: startElement ].
	self requestConfiguration.
	self requestNewSkin
]

{ #category : #'t - triplet element - accessing' }
TToTripletElement >> startElementDo: aBlock [

	startElement ifNotNil: [ :ic | aBlock value: ic ]
]
