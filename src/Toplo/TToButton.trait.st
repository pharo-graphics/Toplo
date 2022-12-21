Trait {
	#name : #TToButton,
	#instVars : [
		'#justified => ObservableSlot',
		'#labelFirst => ObservableSlot'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button presentation' }
TToButton >> beIconFirst [

	self labelFirst: false
]

{ #category : #'t - button presentation' }
TToButton >> beJustified [

	self isJustified: true.

]

{ #category : #'t - button presentation' }
TToButton >> beLabelFirst [

	self labelFirst: true
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
	self privateUpdateRowLayingOut 
]

{ #category : #initialization }
TToButton >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - button initialization' }
TToButton >> initializeButton [

	self layout: BlLinearLayout horizontal.
	self fitContent.
	self label: ToLabel new.
	self icon: ToImage new.
	self label layout alignCenter.
	self icon layout alignCenter.
	
	self privateUpdateRowLayingOut
]

{ #category : #'t - button presentation' }
TToButton >> isIconFirst [
	
	^ self isLabelFirst not
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

{ #category : #'t - button presentation' }
TToButton >> isLabelFirst [
	
	^ self labelFirst
]

{ #category : #'t - button accessing' }
TToButton >> label [

	^ self explicitRequirement
]

{ #category : #'t - button accessing' }
TToButton >> label: aLabel [

	self explicitRequirement
	
]

{ #category : #'t - button presentation' }
TToButton >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]  
]

{ #category : #'t - button presentation' }
TToButton >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateRowLayingOut.
]

{ #category : #'t - button accessing' }
TToButton >> labelText [

	^ self label text
]

{ #category : #'t - button accessing' }
TToButton >> labelText: aText [

	self label text: aText.
	self privateUpdateRowLayingOut.
]

{ #category : #'t - button private' }
TToButton >> privateMatchParentFill [

	^ ToElement new
		  id: #'match-parent-fill';
		  matchParent
]

{ #category : #'t - button private' }
TToButton >> privateUpdateRowLayingOut [

	| subs |
	self removeChildren.
	subs := self rowLayingOut.
	subs ifNil: [ ^ self ].
	subs do: [ :s | 
		s constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	self addChildren: subs
]

{ #category : #'t - button initialization' }
TToButton >> rowLayingOut [

	^ self explicitRequirement 
]

{ #category : #'t - button change hook' }
TToButton >> whenIconImageReplacedDo: aBlock [

	self icon whenInnerImageReplacedDo: aBlock
]

{ #category : #'t - button change hook' }
TToButton >> whenJustifiedChangedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #justified whenChangedDo: aBlock
]

{ #category : #'t - button change hook' }
TToButton >> whenLabelFirstChangedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #labelFirst whenChangedDo: aBlock
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
