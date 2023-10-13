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
TToElementWithLabeledIcon >> icon [

	^ self labeledIcon icon
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> icon: anElement [

	self icon ifNotNil: [ :s | s withoutStamp: #'button-icon'].
	self labeledIcon icon: anElement.
	self icon ifNotNil: [ :s | s withStamp: #'button-icon']
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

	self labeledIcon iconImage: anElement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> interspace: aPointOrSymbol [

	self labeledIcon interspace: aPointOrSymbol
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

	self label ifNotNil: [ :s | s withoutStamp: #'button-label'].
	self labeledIcon label: anElement.
	self label ifNotNil: [ :s | s withStamp: #'button-label'].

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
TToElementWithLabeledIcon >> labelOffset [

	^ self labeledIcon labelOffset
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelOffset: anInteger [

	self labeledIcon labelOffset: anInteger
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelText [

	^ self labeledIcon labelText
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelText: aText [

	self labeledIcon labelText: aText
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labeledIcon [ 

	^ self explicitRequirement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> vertical: aBoolean [

	self labeledIcon vertical: aBoolean
]
