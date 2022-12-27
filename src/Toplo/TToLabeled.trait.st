Trait {
	#name : #TToLabeled,
	#instVars : [
		'#justified => ObservableSlot',
		'#labelFirst => ObservableSlot',
		'#element',
		'#label'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - labeled presentation' }
TToLabeled >> announcePresentationChanged [ 

	self announce: ToLabeledPresentationChangedAnnouncement new  
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beElementFirst [

	self labelFirst: false 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beJustified [

	self isJustified: true
 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beLabelFirst [

	self labelFirst: true 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beNotJustified [

	self isJustified: false

]

{ #category : #'t - labeled accessing' }
TToLabeled >> element [

	^ element 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> element: anElement [

	element = anElement ifTrue: [ ^ self ]. 
	element := anElement.
	self announcePresentationChanged.
	self privateUpdateRowLayingOut.

 
]

{ #category : #'t - labeled initialization' }
TToLabeled >> initializeLabeled [

	self layout: BlLinearLayout horizontal.
	self fitContent.
	self whenLabelFirstChangedDo: [ self announcePresentationChanged ].
	self whenJustifiedChangedDo: [ self announcePresentationChanged ] 
]

{ #category : #'t - button presentation' }
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
	self announcePresentationChanged.
	self privateUpdateRowLayingOut.

]

{ #category : #'t - labeled presentation' }
TToLabeled >> isLabelFirst [
	
	^ self labelFirst 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> label [

	^ label  
]

{ #category : #'t - labeled accessing' }
TToLabeled >> label: aLabel [

	aLabel = label ifTrue: [ ^ self ].
	label := aLabel.
	label layout alignCenter.
	self privateUpdateRowLayingOut.
	self announcePresentationChanged 

	 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]   
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self announcePresentationChanged.
	self privateUpdateRowLayingOut.

]

{ #category : #'t - labeled accessing' }
TToLabeled >> labelText: aText [

	label ifNotNil: [ 
		label text: aText.
		^ self ].
	self label: (ToLabel new text: aText)
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

{ #category : #'t - labeled accessing' }
TToLabeled >> withoutElement [

	self element: nil 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> withoutLabel [

	self label: nil 
]
