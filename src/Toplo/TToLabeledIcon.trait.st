Trait {
	#name : #TToLabeledIcon,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - labeled icon' }
TToLabeledIcon >> beIconFirst [

	self beLeftToRight 
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> beLabelFirst [

	self beRightToLeft
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> icon [

	^ self first
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> icon: anElement [

	self first: anElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> iconImage: anElement [

	self icon ifNotNil: [ :ico | ^ ico innerImage: anElement ].
	self icon: (ToImage inner: anElement)
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> isIconFirst [

	^ self isLeftToRight 
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> isLabelFirst [

	^ self isRightToLeft 
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> label [

	^ self second
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> label: aLabel [

	self second: aLabel
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelFirst: aBoolean [

	aBoolean
		ifTrue: [ self beLabelFirst ]
		ifFalse: [ self beIconFirst ]
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelText: aText [

	self label ifNotNil: [ :lab | ^ lab text: aText ].
	self label: (ToLabel text: aText)
]

{ #category : #enumerating }
TToLabeledIcon >> whenIconChangedDo: aBlock [

	self whenFirstChangedDo: aBlock
]

{ #category : #enumerating }
TToLabeledIcon >> whenLabelChangedDo:  aBlock [

	self whenSecondChangedDo: aBlock
]
