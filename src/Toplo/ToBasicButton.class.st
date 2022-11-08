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

	self layout beHorizontal.
	self requestLayout 
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

	self layout beVertical.
	self requestLayout 
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

	self layout direction: aBlLayoutDirection
]

{ #category : #accessing }
ToBasicButton >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToBasicButton >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToBasicButton >> iconImage [

	^ self viewModel iconImage
]

{ #category : #private }
ToBasicButton >> iconImageReplaced [

	self privateUpdateChildren 
]

{ #category : #accessing }
ToBasicButton >> iconViewModel: anImageViewModel [

	self privateIcon: anImageViewModel privateNewWidget.
	self privateIcon viewModel: anImageViewModel

]

{ #category : #initialization }
ToBasicButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self
		layout: (BlLinearLayout horizontal);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ]
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> isIconFirst [
	
	^ self viewModel isIconFirst
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> isLabelFirst [
	
	^ self viewModel isLabelFirst
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

	self privateUpdateChildren 
]

{ #category : #accessing }
ToBasicButton >> labelViewModel: aLabelViewModel [

	self privateLabel: aLabelViewModel privateNewWidget.
	self privateLabel viewModel: aLabelViewModel


]

{ #category : #'api - orientation/direction' }
ToBasicButton >> orientation [

	^ self layout orientation
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation
]

{ #category : #'api - orientation/direction' }
ToBasicButton >> presentationChanged [
	
		self privateUpdateChildren
]

{ #category : #private }
ToBasicButton >> privateIcon [

	^ icon
]

{ #category : #private }
ToBasicButton >> privateIcon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon := anImage.
	icon ifNotNil: [ icon constraintsDo: [ :c | c linear vertical alignCenter ] ].
	self privateUpdateChildren 
	
]

{ #category : #private }
ToBasicButton >> privateLabel [

	^ label
]

{ #category : #private }
ToBasicButton >> privateLabel: aLabel [

	label = aLabel ifTrue: [ ^ self ].
	label := aLabel.
	label ifNotNil: [ label constraintsDo: [ :c | c linear vertical alignCenter ] ].
	self privateUpdateChildren 
	
]

{ #category : #private }
ToBasicButton >> privateUpdateChildren [

	self removeChildren.
	self isLabelFirst
		ifTrue: [ 
			label ifNotNil: [ self addChild: label ].
			icon ifNotNil: [ self addChild: icon ] ]
		ifFalse: [ 
			icon ifNotNil: [ self addChild: icon ].
			label ifNotNil: [ self addChild: label ] ]
]

{ #category : #accessing }
ToBasicButton >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToBasicButton >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #'api-  action' }
ToBasicButton >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self viewModel whenActionPerformedDo: aBlock
]
