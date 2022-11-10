Class {
	#name : #ToBasicButton,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'label',
		'icon'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToBasicButton >> action [

	^ self viewModel action
]

{ #category : #accessing }
ToBasicButton >> action: aBlock [

	self viewModel action: aBlock
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> beIconFirst [
	
	self labelFirst: false
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> beLabelFirst [
	
	self labelFirst: true
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> beLeftToRight [

	self layout leftToRight.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> beRightToLeft [

	self layout rightToLeft.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> beVertical [

	self horizontal: false
]

{ #category : #'mouse handlers' }
ToBasicButton >> clickEvent: anEvent [

	self isDisabled ifTrue: [ ^ self ].
	self viewModel clickEvent: anEvent
]

{ #category : #initialization }
ToBasicButton >> defaultViewModel [ 

	^ self subclassResponsibility
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> direction [

	^ self layout direction
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> direction: aBlLayoutDirection [

	self layout direction: aBlLayoutDirection.
	self requestLayout 
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> horizontal: aBoolean [

	self viewModel horizontal: aBoolean
]

{ #category : #'private - alignment' }
ToBasicButton >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #'private - alignment' }
ToBasicButton >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToBasicButton >> icon [

	^ icon
]

{ #category : #accessing }
ToBasicButton >> icon: anImage [
	self privateIcon: anImage.
	self privateUpdateChildren 
	
]

{ #category : #accessing }
ToBasicButton >> icon: anImage label: aLabel [

	self privateIcon: anImage.
	self privateLabel: aLabel.
	self privateUpdateChildren 

	
]

{ #category : #private }
ToBasicButton >> iconImageReplaced [

]

{ #category : #private }
ToBasicButton >> iconViewModel: anImageViewModel [

	self icon: anImageViewModel privateNewWidget.
	self icon viewModel: anImageViewModel

]

{ #category : #private }
ToBasicButton >> iconViewModel: anImageViewModel labelViewModel: aLabelViewModel [

	self icon: anImageViewModel privateNewWidget label: aLabelViewModel privateNewWidget.
	self icon viewModel: anImageViewModel.
	self label viewModel: aLabelViewModel

]

{ #category : #initialization }
ToBasicButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	self alignCenter
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> isIconFirst [
	
	^ self viewModel isIconFirst
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> isLabelFirst [
	
	^ self viewModel isLabelFirst
]

{ #category : #accessing }
ToBasicButton >> label [

	^ label
]

{ #category : #accessing }
ToBasicButton >> label: aLabel [

	self privateLabel: aLabel.
	self privateUpdateChildren 
	
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> labelFirst [
	
	^ self viewModel labelFirst
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> labelFirst: aBoolean [
	
	self viewModel labelFirst: aBoolean
]

{ #category : #accessing }
ToBasicButton >> labelText: aText [

	self viewModel labelText: aText
]

{ #category : #private }
ToBasicButton >> labelTextReplaced [

]

{ #category : #private }
ToBasicButton >> labelViewModel: aLabelViewModel [

	self label: aLabelViewModel privateNewWidget.
	self label viewModel: aLabelViewModel


]

{ #category : #'api - orientation/direction' }
ToBasicButton >> orientation [

	^ self layout orientation
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout 
]

{ #category : #private }
ToBasicButton >> orientationChanged [
	
	self viewModel horizontal
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout
]

{ #category : #private }
ToBasicButton >> presentationChanged [
	
	self privateUpdateChildren
]

{ #category : #accessing }
ToBasicButton >> privateIcon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon := anImage.
	
]

{ #category : #accessing }
ToBasicButton >> privateLabel: aLabel [

	label = aLabel ifTrue: [ ^ self ].
	label := aLabel
]

{ #category : #private }
ToBasicButton >> privateUpdateChildren [

	self removeChildren.
	self addChildren: ((self isLabelFirst ifTrue: [ { label. icon } ] ifFalse: [ { icon. label } ]) select: #notNil)
]

{ #category : #'private - alignment' }
ToBasicButton >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #'private - alignment' }
ToBasicButton >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #accessing }
ToBasicButton >> viewModel: aButtonModel [

	super viewModel: aButtonModel.
	self horizontal: aButtonModel horizontal
]

{ #category : #'api-  action' }
ToBasicButton >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self viewModel whenActionPerformedDo: aBlock
]
