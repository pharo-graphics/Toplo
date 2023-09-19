Trait {
	#name : #TToLabeledIcon,
	#instVars : [
		'labelFirstRequested'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> beIconFirst [

	(self includesStyleTag: #'icon-first') ifTrue: [ ^ self ].
	self addStyleTag: #'icon-first'.
	self removeStyleTag: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> beLabelFirst [

	(self includesStyleTag: #'label-first') ifTrue: [ ^ self ].
	self removeStyleTag: #'icon-first'.
	self addStyleTag: #'label-first'.
	self updateSkin.
	self requestLayout
]

{ #category : #'t - labeled icon - direction' }
TToLabeledIcon >> checkDirection [

	self labelFirstRequested
		ifTrue: [ self beLabelFirst ]
		ifFalse: [ self beIconFirst ].

]

{ #category : #'t - labeled icon - orientation' }
TToLabeledIcon >> checkOrientation [

	self verticalRequested
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ].
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

	self replaceFirstWith: anElement
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

	self replaceSecondWith: aLabel
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelFirst: aBoolean [

	aBoolean
		ifTrue: [ self beLabelFirst ]
		ifFalse: [ self beIconFirst ]
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelFirstRequested [

	" useful in case the layout is changed to set the right direction"
	^ labelFirstRequested ifNil: [ labelFirstRequested := self isLabelFirst ]
]

{ #category : #'t - labeled icon - accessing' }
TToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText)
]
