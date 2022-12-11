Trait {
	#name : #TToButton,
	#instVars : [
		'#labelFirst => ObservableSlot',
		'#fill'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button direction' }
TToButton >> beIconFirst [

	self labelFirst: false
]

{ #category : #'t - button presentation' }
TToButton >> beLabelFirst [

	self labelFirst: true
]

{ #category : #'t - button direction' }
TToButton >> beLeftToRight [

	self buttonPane layout leftToRight.
	self buttonPane requestLayout 
]

{ #category : #'t - button direction' }
TToButton >> beRightToLeft [

	self buttonPane layout rightToLeft.
	self buttonPane requestLayout 
]

{ #category : #'t - button accessing' }
TToButton >> buttonPane [

	^ self explicitRequirement
]

{ #category : #'t - button accessing' }
TToButton >> cellSpacing: aNumber [

	self buttonPane layout cellSpacing: aNumber
]

{ #category : #'t - button direction' }
TToButton >> direction [

	^ self buttonPane layout direction
]

{ #category : #'t - button direction' }
TToButton >> direction: aBlLayoutDirection [

	self buttonPane layout direction: aBlLayoutDirection.
	self buttonPane requestLayout 
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

	self icon innerImage: anElement
]

{ #category : #'t - button initialization' }
TToButton >> initializeButton [

	labelFirst := true.
	self buttonPane layout: BlLinearLayout new.
	self buttonPane fitContent.
	self label: ToLabel new.
	self icon: ToImage new.
	self withoutFilling
]

{ #category : #'t - button presentation' }
TToButton >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'t - button presentation' }
TToButton >> isLabelFirst [
	
	^ labelFirst
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

	^ labelFirst
]

{ #category : #'t - button presentation' }
TToButton >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self presentationChanged
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
TToButton >> presentationChanged [
	
	self privateUpdateChildren
]

{ #category : #'t - button private' }
TToButton >> privateFill [

	| e |
	e := ToElement new id: #fill.
	e vExact: 4.
	e hMatchParent.
	^ e
]

{ #category : #'t - button private' }
TToButton >> privateUpdateChildren [

	| subs |
	self buttonPane removeChildren.
	subs := (self isLabelFirst
		         ifTrue: [ 
			         { 
				         self label.
				         fill.
				         self icon } ]
		         ifFalse: [ 
			         { 
				         self icon.
				         fill.
				         self label } ]) select: #notNil.
	subs do: [ :s | 
		s constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	self buttonPane addChildren: subs
]

{ #category : #'t - button change hook' }
TToButton >> whenIconImageReplacedDo: aBlock [

	self icon whenInnerImageReplacedDo: aBlock
]

{ #category : #'t - button change hook' }
TToButton >> whenLabelTextReplacedDo: aBlock [

	self label whenTextReplacedDo: aBlock
]

{ #category : #'t - button change hook' }
TToButton >> whenPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new labelFirst
	 - old labelFirst"

	self property: #labelFirst whenChangedDo: aBlock
]

{ #category : #'t - button accessing' }
TToButton >> withFilling [

	fill := self privateFill.
	self privateUpdateChildren.
]

{ #category : #'t - button accessing' }
TToButton >> withoutFilling [

	fill := nil.
	self privateUpdateChildren.
]

{ #category : #'t - button accessing' }
TToButton >> withoutImage [

	self iconImage: nil
]

{ #category : #'t - button accessing' }
TToButton >> withoutLabel [

	self labelText: nil
]
