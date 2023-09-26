Trait {
	#name : #TToLabeledIcon,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> beIconFirst [

	(self isStampedWith: #'icon-first') ifTrue: [ ^ self ].
	self stampWith: #'icon-first'.
	self removeStyleStampNamed: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> beLabelFirst [

	(self isStampedWith: #'label-first') ifTrue: [ ^ self ].
	self removeStyleStampNamed: #'icon-first'.
	self stampWith: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> extra [

	^ self third
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> extra: anElement [

	self replaceThirdWith: anElement
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

	self first ifNotNil: [ :s | s removeStyleStampNamed: #'button-icon'].
	self replaceFirstWith: anElement.
	self first ifNotNil: [ :s | s stampWith: #'button-icon']
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> iconFirst: aBoolean [

	aBoolean
		ifTrue: [ self beIconFirst ]
		ifFalse: [ self beLabelFirst ]
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
	self second ifNotNil: [ :s | s stampWith: #'button-label'].

]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelFirst: aBoolean [

	aBoolean
		ifTrue: [ self beLabelFirst ]
		ifFalse: [ self beIconFirst ]
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText)
]
