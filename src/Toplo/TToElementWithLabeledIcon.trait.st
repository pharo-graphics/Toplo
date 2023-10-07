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

	self labeledIcon icon: anElement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> iconFirst: aBoolean [

	self labeledIcon iconFirst: aBoolean
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> interspace: aPointOrSymbol [

	self labeledIcon interspace: aPointOrSymbol
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

	self labeledIcon label: anElement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labelFirst: aBoolean [

	self labeledIcon labelFirst: aBoolean
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
TToElementWithLabeledIcon >> labelText: aText [

	self labeledIcon label: (ToLabel text: aText)
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> labeledIcon [ 

	^ self explicitRequirement
]

{ #category : #'t - element with labeled icon - accessing' }
TToElementWithLabeledIcon >> vertical: aBoolean [

	self labeledIcon vertical: aBoolean
]
