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
		'labelFirst',
		'element',
		'label',
		'strategy'
	],
	#category : #'Toplo-Core-Labeled'
}

{ #category : #'t - labeled presentation' }
TToLabeled >> beElementFirst [

	self labelFirst: false 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beJustified [

	self strategy: ToLabeledJustifiedStrategy new
 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> beLabelFirst [

	self labelFirst: true 
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

	self privateUpdateChildren
 
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
	self strategy: ToLabeledWithoutInterspaceStrategy new.
	self fitContent
]

{ #category : #'t - labeled presentation' }
TToLabeled >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'t - labeled presentation' }
TToLabeled >> isJustified [

	^ strategy ifNil: [ false ] ifNotNil: [ :strat | strat isJustified ]
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
	self privateUpdateChildren
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]   
]

{ #category : #'t - labeled presentation' }
TToLabeled >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateChildren
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

	^ strategy
		  ifNil: [ 0 ]
		  ifNotNil: [ :strat | strat leftColumnWidth ]
]

{ #category : #'t - labeled presentation' }
TToLabeled >> leftColumnWidth: anInteger [

	self strategy: (ToLabeledLeftColumnStrategy new width: anInteger)
]

{ #category : #layout }
TToLabeled >> onMeasure: anExtentMeasurementSpec [

	" send to super before to ensure the children are already measured "

	super onMeasure: anExtentMeasurementSpec.
	(self strategy onMeasure: anExtentMeasurementSpec in: self) 
		ifFalse: [ " re-launch measuring if necessary" 
			self onMeasure: anExtentMeasurementSpec ]
]

{ #category : #'t - labeled private' }
TToLabeled >> privateUpdateChildren [

	strategy ifNil: [ ^ self ].
	strategy updateChildrenIn: self
]

{ #category : #'t - labeled accessing' }
TToLabeled >> strategy [

	^ strategy ifNil: [ strategy := ToLabeledWithoutInterspaceStrategy ]
]

{ #category : #'t - labeled accessing' }
TToLabeled >> strategy: aLabeledStrategy [

	strategy := aLabeledStrategy.
	self privateUpdateChildren
]

{ #category : #'t - labeled presentation' }
TToLabeled >> withoutElement [

	self element: nil 
]

{ #category : #'t - labeled presentation' }
TToLabeled >> withoutLabel [

	self label: nil 
]
