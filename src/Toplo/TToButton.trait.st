Trait {
	#name : #TToButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button accessing' }
TToButton >> cellSpacing: aNumber [

	self layout cellSpacing: aNumber
]

{ #category : #'t - button initialization' }
TToButton >> childrenLayout [

	^ self explicitRequirement
]

{ #category : #'t - button direction' }
TToButton >> direction [

	^ self layout direction
]

{ #category : #'t - button direction' }
TToButton >> direction: aBlLayoutDirection [

	self layout direction: aBlLayoutDirection.
	self requestLayout 
]

{ #category : #'t - button accessing' }
TToButton >> icon [

	^ self explicitRequirement
]

{ #category : #'t - button accessing' }
TToButton >> icon: anImage [

	self explicitRequirement
]

{ #category : #'t - button accessing' }
TToButton >> iconImage [

	^ self icon hasInnerImage ifTrue: [ self icon innerImage ] ifFalse: [ nil ]
]

{ #category : #'t - button accessing' }
TToButton >> iconImage: anElement [

	self icon innerImage: anElement
]

{ #category : #'t - button initialization' }
TToButton >> initializeButton [

	self layout: BlLinearLayout horizontal.
	self fitContent.
	self label: ToLabel new.
	self icon: ToImage new.
	
	self privateUpdateChildren 
]

{ #category : #'t - button accessing' }
TToButton >> label [

	^ self explicitRequirement
]

{ #category : #'t - button accessing' }
TToButton >> label: aLabel [

	self explicitRequirement
	
]

{ #category : #'t - button accessing' }
TToButton >> labelText [

	^ self label hasText ifTrue: [ self label text ] ifFalse: [ nil ]
]

{ #category : #'t - button accessing' }
TToButton >> labelText: aText [

	self label text: aText
]

{ #category : #'t - button private' }
TToButton >> privateFill [

	^ ToElement new id: #fill; matchParent.

]

{ #category : #'t - button private' }
TToButton >> privateUpdateChildren [

	| subs |
	self removeChildren.
	subs := self childrenLayout.
	subs do: [ :s | 
		s constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	self addChildren: subs
]

{ #category : #'t - button change hook' }
TToButton >> whenIconImageReplacedDo: aBlock [

	self icon whenInnerImageReplacedDo: aBlock
]

{ #category : #'t - button change hook' }
TToButton >> whenLabelTextReplacedDo: aBlock [

	self label whenTextReplacedDo: aBlock
]

{ #category : #'t - button accessing' }
TToButton >> withoutImage [

	self iconImage: nil
]

{ #category : #'t - button accessing' }
TToButton >> withoutLabel [

	self labelText: nil
]
