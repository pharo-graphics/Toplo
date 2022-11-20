Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'#label',
		'#icon',
		'#labelFirst => ObservableSlot',
		'#horizontal => ObservableSlot'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'api - orientation/direction' }
ToButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'api - orientation/direction' }
ToButton >> beIconFirst [

	self labelFirst: false
]

{ #category : #'api - presentation' }
ToButton >> beLabelFirst [

	self labelFirst: true
]

{ #category : #'api - orientation/direction' }
ToButton >> beLeftToRight [

	self layout leftToRight.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToButton >> beRightToLeft [

	self layout rightToLeft.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToButton >> beVertical [

	self horizontal: false
]

{ #category : #accessing }
ToButton >> cellSpacing: aNumber [

	self layout cellSpacing: aNumber
]

{ #category : #initialization }
ToButton >> defaultViewModel [ 

	^ ToButtonModel new
]

{ #category : #'api - orientation/direction' }
ToButton >> direction [

	^ self layout direction
]

{ #category : #'api - orientation/direction' }
ToButton >> direction: aBlLayoutDirection [

	self layout direction: aBlLayoutDirection.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToButton >> horizontal [

	^ horizontal
]

{ #category : #'api - orientation/direction' }
ToButton >> horizontal: aBoolean [

	horizontal = aBoolean ifTrue: [ ^ self ].
	horizontal := aBoolean.
	self orientationChanged 
]

{ #category : #'private - alignment' }
ToButton >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #'private - alignment' }
ToButton >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToButton >> icon [

	^ icon
]

{ #category : #accessing }
ToButton >> icon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon := anImage.
	self privateUpdateChildren
]

{ #category : #accessing }
ToButton >> iconImage [

	^ icon innerImage
]

{ #category : #accessing }
ToButton >> iconImage: anElement [

	icon innerImage: anElement
]

{ #category : #private }
ToButton >> iconImageReplaced [

]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	horizontal := true.
	labelFirst := false.
	self
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	self alignCenter.
	label := ToLabel new.
	icon := ToImage new.
	self privateUpdateChildren.
	self whenLabelTextReplacedDo: [ self labelTextReplaced ].
	self whenIconImageReplacedDo: [ self iconImageReplaced ]
]

{ #category : #'api - presentation' }
ToButton >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'api - presentation' }
ToButton >> isLabelFirst [
	
	^ labelFirst
]

{ #category : #accessing }
ToButton >> label [

	^ label
]

{ #category : #accessing }
ToButton >> label: aLabel [

	label = aLabel ifTrue: [ ^ self ].
	label := aLabel.
	self privateUpdateChildren 
	
]

{ #category : #'api - presentation' }
ToButton >> labelFirst [

	^ labelFirst
]

{ #category : #'api - presentation' }
ToButton >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self presentationChanged
]

{ #category : #accessing }
ToButton >> labelText [

	^ label text
]

{ #category : #accessing }
ToButton >> labelText: aText [

	label text: aText
]

{ #category : #private }
ToButton >> labelTextReplaced [

]

{ #category : #'api - orientation/direction' }
ToButton >> orientation [

	^ self layout orientation
]

{ #category : #'api - orientation/direction' }
ToButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout 
]

{ #category : #private }
ToButton >> orientationChanged [
	
	self horizontal
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout
]

{ #category : #private }
ToButton >> presentationChanged [
	
	self privateUpdateChildren
]

{ #category : #private }
ToButton >> privateUpdateChildren [

	self removeChildren.
	self addChildren: ((self isLabelFirst ifTrue: [ { label. icon } ] ifFalse: [ { icon. label } ]) select: #notNil)
]

{ #category : #'private - alignment' }
ToButton >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #'private - alignment' }
ToButton >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #'api - change hook' }
ToButton >> whenIconImageReplacedDo: aBlock [

	icon whenInnerImageReplacedDo: aBlock
]

{ #category : #'api - change hook' }
ToButton >> whenLabelTextReplacedDo: aBlock [

	label whenTextReplacedDo: aBlock
]

{ #category : #'api - change hook' }
ToButton >> whenOrientationChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #horizontal whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToButton >> whenPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new labelFirst
	 - old labelFirst"

	self property: #labelFirst whenChangedDo: aBlock
]

{ #category : #accessing }
ToButton >> withoutImage [

	self iconImage: nil
]

{ #category : #accessing }
ToButton >> withoutLabel [

	self labelText: nil
]
