Trait {
	#name : #TToLabeledIcon,
	#traits : 'TToTriplet + TToOrientable',
	#classTraits : 'TToTriplet classTrait + TToOrientable classTrait',
	#category : #'Toplo-Core-Triplet'
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
TToLabeledIcon >> extra [

	^ self third
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> extra: anElement [

	self replaceThirdWith: anElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> icon [

	^ self first
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> icon: anElement [

	self replaceFirstWith: anElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> iconImage: anElement [

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

	self replaceSecondWith: aLabel
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelFirst: aBoolean [

	aBoolean
		ifTrue: [ self beLabelFirst ]
		ifFalse: [ self beIconFirst ]
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText)
]
