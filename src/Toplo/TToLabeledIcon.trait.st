Trait {
	#name : #TToLabeledIcon,
	#category : #'Toplo-Core'
}

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> beIconFirst [

	(self hasStamp: #'icon-first') ifTrue: [ ^ self ].
	self withStamp: #'icon-first'.
	self withoutStamp: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> beLabelFirst [

	(self hasStamp: #'label-first') ifTrue: [ ^ self ].
	self withoutStamp: #'icon-first'.
	self withStamp: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #'t - labeled icon - testing' }
TToLabeledIcon >> hasIcon [

	^ self icon notNil
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> icon [

	^ self first
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> icon: anElement [

	self first ifNotNil: [ :s | s withoutStamp: #'button-icon'].
	self replaceFirstWith: anElement.
	self first ifNotNil: [ :s | s withStamp: #'button-icon']
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> iconFirst: aBoolean [

	aBoolean
		ifTrue: [ self beIconFirst ]
		ifFalse: [ self beLabelFirst ]
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> iconImage [

	^ self icon innerImage
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> isIconFirst [

	^ self isLeftToRight 
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> isLabelFirst [

	^ self isRightToLeft 
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> label [

	^ self second
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> label: aLabel [

	self second ifNotNil: [ :s | s removeStyleStampNamed: #'button-label'].
	self replaceSecondWith: aLabel.
	self second ifNotNil: [ :s | s withStamp: #'button-label'].

]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelFirst: aBoolean [

	aBoolean
		ifTrue: [ self beLabelFirst ]
		ifFalse: [ self beIconFirst ]
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelText [

	^ self label text
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText)
]
