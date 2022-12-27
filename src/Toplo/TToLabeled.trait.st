Trait {
	#name : #TToLabeled,
	#instVars : [
		'#justified => ObservableSlot',
		'#labelFirst => ObservableSlot',
		'#element',
		'#interspace',
		'#label',
		'#leftColumnWidth'
	],
	#category : #'Toplo-Widget-Button'
}

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

{ #category : #'t - labeled initialization' }
TToLabeled >> defaultLeftColumnWidth [

	" -1 means no default "
	^ -1 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> element [

	^ element 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> element: anElement [

	element = anElement ifTrue: [ ^ self ]. 
	element := anElement.
	self privateUpdateRowLayingOut.

 
]

{ #category : #'t - labeled initialization' }
TToLabeled >> initializeLabeled [

	self layout: BlLinearLayout horizontal.
	self fitContent.

]

{ #category : #layout }
TToLabeled >> interspaceMeasure: anExtentMeasurementSpec [

	| w left lw |
	self isJustified ifTrue: [ 
		interspace := self privateMatchParentFill.
		^ self ].

	" get the left side element "
	left := self isLabelFirst
		        ifTrue: [ self label ]
		        ifFalse: [ self element ].

	lw := left ifNil: [ 0 ] ifNotNil: [ left measuredWidth ].
	" now measure the gap according to leftColumnWidth "
	w := self leftColumnWidth - lw max: 0.

	interspace ifNotNil: [ " adapt the existing fill "
		interspace measuredWidth = w ifTrue: [ ^ self ].
		interspace measuredExtent: w @ 0.
		interspace constraintsDo: [ :c | 
			c horizontal exact: w.
			c vertical exact: 0 ].
		^ self ].

	" first pass, create the fill "
	interspace := BlElement new
		              id: #'icon-column-fill';
		              measuredExtent: w @ 0;
		              yourself.
	interspace constraintsDo: [ :c | 
		c horizontal exact: w.
		c vertical exact: 0 ]
]

{ #category : #'t - labeled presentation' }
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
	self requestLayout.
	self whenLayoutedDoOnce: [ self privateUpdateRowLayingOut ].
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
	self privateUpdateRowLayingOut
	 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]   
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self requestLayout.
	self whenLayoutedDoOnce: [ self privateUpdateRowLayingOut ].
]

{ #category : #'t - labeled accessing' }
TToLabeled >> labelText: aText [

	label ifNotNil: [ 
		label text: aText.
		^ self ].
	self label: (ToLabel new text: aText)
]

{ #category : #'t - labeled presentation' }
TToLabeled >> leftColumnWidth [

	^ leftColumnWidth ifNil: [ leftColumnWidth := self defaultLeftColumnWidth].

]

{ #category : #'t - labeled presentation' }
TToLabeled >> leftColumnWidth: anInteger [

	leftColumnWidth := anInteger.
	self requestLayout.
	self whenLayoutedDoOnce: [ self privateUpdateRowLayingOut ].
]

{ #category : #layout }
TToLabeled >> onMeasure: anExtentMeasurementSpec [

	self interspaceMeasure: anExtentMeasurementSpec.
	super onMeasure: anExtentMeasurementSpec
	
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
	self eventDispatcher disableLayoutChanged.
	[ self removeChildren ] ensure: [ 
		self eventDispatcher enableLayoutChanged ].
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

	^ (self isLabelFirst
		   ifTrue: [ 
			   { 
				   self label.
				   interspace.
				   self element } ]
		   ifFalse: [ 
			   { 
				   self element.
				   interspace.
				   self label } ]) select: #notNil
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

{ #category : #'t - labeled presentation' }
TToLabeled >> withoutElement [

	self element: nil 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> withoutLabel [

	self label: nil 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> withoutLeftColumn [

	self leftColumnWidth: -1
]
