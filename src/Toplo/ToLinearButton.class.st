Class {
	#name : #ToLinearButton,
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
ToLinearButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> beIconFirst [
	
	self labelFirst: false
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> beLabelFirst [
	
	self labelFirst: true
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> beLeftToRight [

	self layout leftToRight.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> beRightToLeft [

	self layout rightToLeft.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> beVertical [

	self horizontal: false
]

{ #category : #initialization }
ToLinearButton >> defaultViewModel [ 

	^ self subclassResponsibility
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> direction [

	^ self layout direction
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> direction: aBlLayoutDirection [

	self layout direction: aBlLayoutDirection.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> horizontal [

	^ self viewModel horizontal
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> horizontal: aBoolean [

	self viewModel horizontal: aBoolean
]

{ #category : #'private - alignment' }
ToLinearButton >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #'private - alignment' }
ToLinearButton >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToLinearButton >> icon [

	^ icon
]

{ #category : #accessing }
ToLinearButton >> icon: anImage [
	self privateIcon: anImage.
	self privateUpdateChildren 
	
]

{ #category : #accessing }
ToLinearButton >> icon: anImage label: aLabel [

	self privateIcon: anImage.
	self privateLabel: aLabel.
	self privateUpdateChildren 

	
]

{ #category : #accessing }
ToLinearButton >> iconImage: anElement [

	self viewModel iconImage: anElement
]

{ #category : #private }
ToLinearButton >> iconImageReplaced [

]

{ #category : #private }
ToLinearButton >> iconViewModel: anImageViewModel [

	self icon: anImageViewModel privateNewWidget.
	"self icon viewModel: anImageViewModel"

]

{ #category : #private }
ToLinearButton >> iconViewModel: anImageViewModel labelViewModel: aLabelViewModel [

	self icon: anImageViewModel privateNewWidget label: aLabelViewModel privateNewWidget.
	"self icon viewModel: anImageViewModel.
	self label viewModel: aLabelViewModel
"
]

{ #category : #initialization }
ToLinearButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	self alignCenter
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> isIconFirst [
	
	^ self viewModel isIconFirst
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> isLabelFirst [
	
	^ self viewModel isLabelFirst
]

{ #category : #accessing }
ToLinearButton >> label [

	^ label
]

{ #category : #accessing }
ToLinearButton >> label: aLabel [

	self privateLabel: aLabel.
	self privateUpdateChildren 
	
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> labelFirst [
	
	^ self viewModel labelFirst
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> labelFirst: aBoolean [
	
	self viewModel labelFirst: aBoolean
]

{ #category : #accessing }
ToLinearButton >> labelText: aText [

	self viewModel labelText: aText
]

{ #category : #private }
ToLinearButton >> labelTextReplaced [

]

{ #category : #private }
ToLinearButton >> labelViewModel: aLabelViewModel [

	self label: aLabelViewModel privateNewWidget.
	"self label viewModel: aLabelViewModel"


]

{ #category : #'api - orientation/direction' }
ToLinearButton >> orientation [

	^ self layout orientation
]

{ #category : #'api - orientation/direction' }
ToLinearButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout 
]

{ #category : #private }
ToLinearButton >> orientationChanged [
	
	self viewModel horizontal
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout
]

{ #category : #private }
ToLinearButton >> presentationChanged [
	
	self privateUpdateChildren
]

{ #category : #private }
ToLinearButton >> privateIcon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon := anImage.
	
]

{ #category : #private }
ToLinearButton >> privateLabel: aLabel [

	label = aLabel ifTrue: [ ^ self ].
	label := aLabel
]

{ #category : #private }
ToLinearButton >> privateUpdateChildren [

	self removeChildren.
	self addChildren: ((self isLabelFirst ifTrue: [ { label. icon } ] ifFalse: [ { icon. label } ]) select: #notNil)
]

{ #category : #'private - alignment' }
ToLinearButton >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #'private - alignment' }
ToLinearButton >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #accessing }
ToLinearButton >> viewModel: aButtonModel [

	super viewModel: aButtonModel.
	"self horizontal: aButtonModel horizontal"
]
