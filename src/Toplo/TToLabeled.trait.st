Trait {
	#name : #TToLabeled,
	#instVars : [
		'#justified => ObservableSlot',
		'#labelFirst => ObservableSlot',
		'#label',
		'#element'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'as yet unclassified' }
TToLabeled >> beIconFirst [

	self labelFirst: false
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beJustified [

	self isJustified: true.

]

{ #category : #'t - labeled presentation' }
TToLabeled >> beLabelFirst [

	self labelFirst: true
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beNotJustified [

	self isJustified: false.

]

{ #category : #'as yet unclassified' }
TToLabeled >> hasIcon [

	^ self icon hasInnerImage 
]

{ #category : #'as yet unclassified' }
TToLabeled >> hasLabel [

	^ self label text isNotEmpty
]

{ #category : #'as yet unclassified' }
TToLabeled >> icon [

	^ self explicitRequirement
]

{ #category : #'as yet unclassified' }
TToLabeled >> icon: anImage [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
TToLabeled >> iconImage [

	^ self icon innerImage
]

{ #category : #'as yet unclassified' }
TToLabeled >> iconImage: anElement [

	self icon innerImage: anElement.
	self iconImage constraintsDo: [ :c | 
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].
	self privateUpdateRowLayingOut 
]

{ #category : #initialization }
TToLabeled >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'as yet unclassified' }
TToLabeled >> initializeButton [

	self layout: BlLinearLayout horizontal.
	self fitContent.
	self label: ToLabel new.
	self icon: ToImage new.
	self label layout alignCenter.
	self icon layout alignCenter.
	
	self privateUpdateRowLayingOut
]

{ #category : #'as yet unclassified' }
TToLabeled >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'t - labeled presentation' }
TToLabeled >> isJustified [

	^ justified ifNil: [ justified := false ]
]

{ #category : #'t - labeled presentation' }
TToLabeled >> isJustified: aBoolean [

	justified = aBoolean ifTrue: [ ^self ].
	justified := aBoolean.
	self announce: ToMenuPresentationChangedAnnouncement new
]

{ #category : #'t - labeled presentation' }
TToLabeled >> isLabelFirst [
	
	^ self labelFirst
]

{ #category : #'t - labeled accessing' }
TToLabeled >> label [

	^ self explicitRequirement
]

{ #category : #'t - labeled accessing' }
TToLabeled >> label: aLabel [

	self explicitRequirement
	
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]  
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateRowLayingOut.
]

{ #category : #'as yet unclassified' }
TToLabeled >> labelText [

	^ self label text
]

{ #category : #'t - labeled accessing' }
TToLabeled >> labelText: aText [

	self label text: aText.
	self privateUpdateRowLayingOut.
]

{ #category : #'t - labeled private' }
TToLabeled >> privateMatchParentFill [

	^ ToElement new
		  id: #'match-parent-fill';
		  matchParent
]

{ #category : #'t - labeled private' }
TToLabeled >> privateUpdateRowLayingOut [

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

{ #category : #'t - labeled initialization' }
TToLabeled >> rowLayingOut [

	^ self explicitRequirement 
]

{ #category : #'as yet unclassified' }
TToLabeled >> whenIconImageReplacedDo: aBlock [

	self icon whenInnerImageReplacedDo: aBlock
]

{ #category : #'t - labeled change hook' }
TToLabeled >> whenJustifiedChangedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #justified whenChangedDo: aBlock
]

{ #category : #'t - labeled change hook' }
TToLabeled >> whenLabelFirstChangedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #labelFirst whenChangedDo: aBlock
]

{ #category : #'as yet unclassified' }
TToLabeled >> whenLabelTextReplacedDo: aBlock [

	self label whenTextReplacedDo: aBlock
]

{ #category : #'as yet unclassified' }
TToLabeled >> withoutImage [

	self iconImage: nil
]

{ #category : #'t - labeled accessing' }
TToLabeled >> withoutLabel [

	self labelText: nil
]
