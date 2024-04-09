Trait {
	#name : #TToElementWithLabeledIcon,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beEndToStart [

	self labeledIcon beEndToStart
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beHorizontal [

	self labeledIcon beHorizontal
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beStartToEnd [

	self labeledIcon beStartToEnd
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beVertical [

	self labeledIcon beVertical
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endAlignment [

	^ self labeledIcon endAlignment
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endAlignment: anInteger [

	self labeledIcon endAlignment: anInteger
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endContainer [

	^ self labeledIcon endContainer
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endContainerHeight [

	^ self labeledIcon endContainerHeight
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endElement [

	^ self labeledIcon endElement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endElement: anElement [

	self endElement = anElement ifTrue: [ ^ self ].
	self labeledIcon endElement: anElement.
	self requestNewSkin
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endElementDo: aBlock [

	self endElement ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endFiller [ 

	^ self labeledIcon endFiller
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endFlexible: aBoolean [

	self labeledIcon endFlexible: aBoolean
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endInterspace [

	^ self labeledIcon endInterspace
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endInterspace: aPoint [

	self endInterspace = aPoint asPoint ifTrue: [ ^ self ].
	self labeledIcon endInterspace: aPoint asPoint
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> endToStart: aBoolean [

	self labeledIcon endToStart: aBoolean
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> hasEndElement [

	^ self labeledIcon hasEndElement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> hasIcon [

	^ self labeledIcon hasIcon
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> hasLabel [

	^ self labeledIcon hasLabel
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> icon [

	^ self labeledIcon icon
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> icon: anElement [

	self icon = anElement ifTrue: [ ^ self ].
	self labeledIcon icon: anElement.
	self requestNewSkin
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconContainer [

	^ self labeledIcon iconContainer
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconContainerHeight [

	^ self labeledIcon iconContainerHeight
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconContainerHeight: anInteger [

	self labeledIcon iconContainerHeight: anInteger
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconContainerWidth [

	^ self labeledIcon iconContainerWidth
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconContainerWidth: anInteger [

	self labeledIcon iconContainerWidth: anInteger
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconDo: aBlock [

	self icon ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconImage [

	^ self labeledIcon iconImage
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isEndFlexible [

	^ self labeledIcon isEndFlexible
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isEndToStart [

	^ self labeledIcon isEndToStart
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isExact [

	^ self labeledIcon isExact
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isHorizontal [

	^ self labeledIcon isHorizontal
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isStartFlexible [

	^ self labeledIcon isStartFlexible
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isStartToEnd [

	^ self labeledIcon isStartToEnd
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isVertical [

	^ self labeledIcon isVertical
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> label [

	^ self labeledIcon label
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> label: anElement [

	self label = anElement ifTrue: [ ^ self ].
	self labeledIcon label: anElement.
	self requestNewSkin
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelContainer [

	^ self labeledIcon labelContainer
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelDo: aBlock [

	self label ifNotNil: [ :la | aBlock value: la ]
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelIconfiller [

	^ self labeledIcon startFiller
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelText [

	^ self labeledIcon labelText
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelText: aText [

	aText ifNil: [ self label: nil ].
	self label: (ToLabel text: aText asRopedText)
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labeledIcon [ 

	^ self explicitRequirement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startAlignment [

	^ self labeledIcon startAlignment
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startAlignment: anInteger [

	self labeledIcon startAlignment: anInteger
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startFiller [ 

	^ self labeledIcon startFiller
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startFlexible: aBoolean [

	self labeledIcon startFlexible: aBoolean
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startInterspace [

	^ self labeledIcon startInterspace
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startInterspace: aPoint [

	self startInterspace = aPoint asPoint ifTrue: [ ^ self ].
	self labeledIcon startInterspace: aPoint asPoint
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> startToEnd: aBoolean [

	self labeledIcon startToEnd: aBoolean
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> vertical: aBoolean [

	self labeledIcon vertical: aBoolean
]
