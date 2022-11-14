Class {
	#name : #ToButton,
	#superclass : #ToBasicButton,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'label',
		'icon'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - orientation/direction' }
ToButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'api - orientation/direction' }
ToButton >> beIconFirst [
	
	self labelFirst: false
]

{ #category : #'api - orientation/direction' }
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

	^ self viewModel horizontal
]

{ #category : #'api - orientation/direction' }
ToButton >> horizontal: aBoolean [

	self viewModel horizontal: aBoolean
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
	self privateIcon: anImage.
	self privateUpdateChildren 
	
]

{ #category : #accessing }
ToButton >> icon: anImage label: aLabel [

	self privateIcon: anImage.
	self privateLabel: aLabel.
	self privateUpdateChildren 

	
]

{ #category : #accessing }
ToButton >> iconImage: anElement [

	self viewModel iconImage: anElement
]

{ #category : #private }
ToButton >> iconImageReplaced [

]

{ #category : #private }
ToButton >> iconViewModel: anImageViewModel [

	self icon: anImageViewModel privateNewWidget.
	"self icon viewModel: anImageViewModel"

]

{ #category : #private }
ToButton >> iconViewModel: anImageViewModel labelViewModel: aLabelViewModel [

	self icon: anImageViewModel privateNewWidget label: aLabelViewModel privateNewWidget.
	"self icon viewModel: anImageViewModel.
	self label viewModel: aLabelViewModel
"
]

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	self alignCenter
]

{ #category : #'api - orientation/direction' }
ToButton >> isIconFirst [
	
	^ self viewModel isIconFirst
]

{ #category : #'api - orientation/direction' }
ToButton >> isLabelFirst [
	
	^ self viewModel isLabelFirst
]

{ #category : #accessing }
ToButton >> label [

	^ label
]

{ #category : #accessing }
ToButton >> label: aLabel [

	self privateLabel: aLabel.
	self privateUpdateChildren 
	
]

{ #category : #'api - orientation/direction' }
ToButton >> labelFirst [
	
	^ self viewModel labelFirst
]

{ #category : #'api - orientation/direction' }
ToButton >> labelFirst: aBoolean [
	
	self viewModel labelFirst: aBoolean
]

{ #category : #accessing }
ToButton >> labelText: aText [

	self viewModel labelText: aText
]

{ #category : #private }
ToButton >> labelTextReplaced [

]

{ #category : #private }
ToButton >> labelViewModel: aLabelViewModel [

	self label: aLabelViewModel privateNewWidget.
	"self label viewModel: aLabelViewModel"


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
	
	self viewModel horizontal
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout
]

{ #category : #private }
ToButton >> presentationChanged [
	
	self privateUpdateChildren
]

{ #category : #private }
ToButton >> privateIcon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon := anImage.
	
]

{ #category : #private }
ToButton >> privateLabel: aLabel [

	label = aLabel ifTrue: [ ^ self ].
	label := aLabel
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

{ #category : #accessing }
ToButton >> viewModel: aButtonModel [

	super viewModel: aButtonModel.
	"self horizontal: aButtonModel horizontal"
]
