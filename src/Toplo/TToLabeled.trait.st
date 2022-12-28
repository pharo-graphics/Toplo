"
A lot of kind of views consist in a Label associated with another element sur as an image or an icon, a text...
I represent such a view. Basically, I hold a label and another element. I'm used to build buttons and menu items and as a basic block to implement elements viewed within a list, a table or a tree .

The label and the associated element are optional. I can hold a label alone or a label associated with another element or an element alone without any label.

Internal Representation and Key Implementation Points.

    Instance Variables
	element:		<BlElement> 
	interspace:		<BlElement> a transparent element which is used for the appropriate laying-out of the label and the associted element
	justified:		<Boolean> if set to true, then the label and its associated alement are located on the left and on the right side.
	label:		<ToLabel> 
	labelFirst:		<Boolean> if true, then the label layed-out on the left of the element
	leftColumnWidth:		<Integer> the size of the left column (mainly used to align labels (or icons) in menus)


    Implementation Points
"
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
	#category : #'Toplo-Core'
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

	^ 0 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> element [

	^ element 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> element: anElement [

	element = anElement ifTrue: [ ^ self ]. 
	element := anElement.
		element ifNotNil: [ 
		element constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	self privateUpdateLayingOut
 
]

{ #category : #'t - labeled accessing' }
TToLabeled >> icon [

	^ self element
]

{ #category : #'t - labeled accessing' }
TToLabeled >> icon: anImage [

	self element: anImage
]

{ #category : #'t - labeled accessing' }
TToLabeled >> iconImage: anInnerImage [

	self element: (ToImage inner: anInnerImage)
]

{ #category : #'t - labeled initialization' }
TToLabeled >> initializeLabeled [

	self layout: BlLinearLayout horizontal.
	interspace := BlElement new constraintsDo: [ :c | 
		              c horizontal exact: 0.
		              c vertical exact: 0 ].
	self fitContent
]

{ #category : #layout }
TToLabeled >> interspaceMeasure: anExtentMeasurementSpec [

	| w left lw |
	self isJustified ifTrue: [ 
		(interspace constraints horizontal resizer isMatchParent and: [ 
			 interspace constraints vertical resizer isMatchParent ]) ifFalse: [ 
			interspace constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ]. ^ false].
		^ true ].

	" cell spacing is not compatible with left column sizing "
	self layout cellSpacing isZero ifFalse: [ ^ true ].

	" get the left side element and then its width "
	left := self isLabelFirst
		        ifTrue: [ self label ]
		        ifFalse: [ self element ].

	lw := left ifNil: [ 0 ] ifNotNil: [ left measuredWidth ].
	" now measure the gap according to leftColumnWidth "
	w := self leftColumnWidth - lw max: 0.

	interspace measuredWidth = w ifTrue: [ ^ true ].
	interspace measuredExtent: w @ 0.
	interspace size: w @ 0.
	^ false
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
	self privateUpdateLayingOut
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
	label ifNotNil: [ 
		label layout alignCenter.
		label constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	self privateUpdateLayingOut
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]   
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateLayingOut
]

{ #category : #'t - labeled accessing' }
TToLabeled >> labelText: aText [

	label ifNotNil: [ 
		label text: aText.
		^ self ].
	self label: (ToLabel new text: aText)
]

{ #category : #'t - labeled initialization' }
TToLabeled >> layingOut [

	^ (self isLabelFirst
		   ifTrue: [ 
			   { 
				   self label.
				   self privateUsedInterspace.
				   self element } ]
		   ifFalse: [ 
			   { 
				   self element.
				   self privateUsedInterspace.
				   self label } ]) select: #notNil
]

{ #category : #'t - labeled presentation' }
TToLabeled >> leftColumnWidth [

	^ leftColumnWidth ifNil: [ leftColumnWidth := self defaultLeftColumnWidth].

]

{ #category : #'t - labeled presentation' }
TToLabeled >> leftColumnWidth: anInteger [

	leftColumnWidth := anInteger.
	self requestLayout.
	self whenLayoutedDoOnce: [ self privateUpdateLayingOut ]
]

{ #category : #layout }
TToLabeled >> onMeasure: anExtentMeasurementSpec [

	" send to super before to ensure the children are already measured "

	super onMeasure: anExtentMeasurementSpec.
	(self interspaceMeasure: anExtentMeasurementSpec) ifFalse: [ 
		self onMeasure: anExtentMeasurementSpec ]
]

{ #category : #'t - labeled private' }
TToLabeled >> privateJustificationFill [

	^ ToElement new
		  id: self privateJustificationFillId;
		  matchParent 
]

{ #category : #'t - labeled private' }
TToLabeled >> privateJustificationFillId [

	^ #'justification'
]

{ #category : #'t - labeled private' }
TToLabeled >> privateUpdateLayingOut [

	| subs |
	
	subs := self layingOut.
	self children asArray = subs ifTrue: [ ^ self ].
	self eventDispatcher disableLayoutChanged.
	[ self removeChildren ] ensure: [ 
		self eventDispatcher enableLayoutChanged ].
	self addChildren: subs
]

{ #category : #'t - labeled private' }
TToLabeled >> privateUsedInterspace [

	^ (self isJustified or: [ self leftColumnWidth > 0 ])
		  ifTrue: [ interspace ]
		  ifFalse: [ nil ]
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
