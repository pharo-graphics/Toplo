Trait {
	#name : #TToButton,
	#instVars : [
		'justified'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button presentation' }
TToButton >> beJustified [

	self isJustified: true.

]

{ #category : #'t - button presentation' }
TToButton >> beNotJustified [

	self isJustified: false.

]

{ #category : #'t - button testing' }
TToButton >> hasIcon [

	^ self icon hasInnerImage 
]

{ #category : #'t - button testing' }
TToButton >> hasLabel [

	^ self label text isNotEmpty
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

	^ self icon innerImage
]

{ #category : #'t - button accessing' }
TToButton >> iconImage: anElement [

	self icon innerImage: anElement.
	self iconImage constraintsDo: [ :c | 
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].
	self privateUpdateChildren 
]

{ #category : #'t - button initialization' }
TToButton >> initializeButton [

	self layout: BlLinearLayout horizontal.
	self fitContent.
	self label: ToLabel new.
	self icon: ToImage new.
	self label layout alignCenter.
	self icon layout alignCenter.
	
	self privateUpdateChildren
]

{ #category : #'t - button presentation' }
TToButton >> isJustified [

	^ justified ifNil: [ justified := false ]
]

{ #category : #'t - button presentation' }
TToButton >> isJustified: aBoolean [

	justified = aBoolean ifTrue: [ ^self ].
	justified := aBoolean.
	self announce: ToMenuPresentationChangedAnnouncement new
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

	^ self label text
]

{ #category : #'t - button accessing' }
TToButton >> labelText: aText [

	self label text: aText
]

{ #category : #'t - button private' }
TToButton >> privateMatchParentFill [

	^ ToElement new
		  id: #'match-parent-fill';
		  matchParent
]

{ #category : #'t - button private' }
TToButton >> privateUpdateChildren [

	| subs |
	self removeChildren.
	subs := self rowLayout.
	subs do: [ :s | 
		s constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	self addChildren: subs
]

{ #category : #'t - button initialization' }
TToButton >> rowLayout [

	^ self explicitRequirement 
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
