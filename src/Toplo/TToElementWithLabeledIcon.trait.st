Trait {
	#name : #TToElementWithLabeledIcon,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beHorizontal [

	self labeledIcon beHorizontal
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beIconFirst [

	self labeledIcon beIconFirst
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beLabelFirst [

	self labeledIcon beLabelFirst
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> beVertical [

		self labeledIcon beVertical
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> filler [ 

	^ self labeledIcon filler
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> flexible [

	^ self labeledIcon flexible
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> flexible: aBoolean [

	self labeledIcon flexible: aBoolean
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
TToElementWithLabeledIcon >> iconFirst: aBoolean [

	self labeledIcon iconFirst: aBoolean
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
TToElementWithLabeledIcon >> interspace [

	^ self labeledIcon interspace
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> interspace: aPoint [

	self interspace = aPoint asPoint ifTrue: [ ^ self ].
	self labeledIcon interspace: aPoint asPoint
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isExact [

	^ self labeledIcon isExact
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isFlexible [

	^ self labeledIcon isFlexible
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isHorizontal [

	^ self labeledIcon isHorizontal
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isIconFirst [

	^ self labeledIcon isIconFirst
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> isLabelFirst [

	^ self labeledIcon isLabelFirst
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
TToElementWithLabeledIcon >> labelFirst: aBoolean [

	self labeledIcon labelFirst: aBoolean
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelIconfiller [

	^ self labeledIcon filler
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
TToElementWithLabeledIcon >> rightLabelAlignment [

	^ self labeledIcon rightLabelAlignment
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> rightLabelAlignment: anInteger [

	self labeledIcon rightLabelAlignment: anInteger
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> vertical: aBoolean [

	self labeledIcon vertical: aBoolean
]
