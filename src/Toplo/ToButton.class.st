Class {
	#name : #ToButton,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'label',
		'icon',
		'labelFirst'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToButton >> action [

	^ self viewModel action
]

{ #category : #accessing }
ToButton >> action: aBlock [

	self viewModel action: aBlock
]

{ #category : #'api - orientation/direction' }
ToButton >> beHorizontal [ 

	self layout beHorizontal.
	self requestLayout 
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

	self layout beVertical.
	self requestLayout 
]

{ #category : #initialization }
ToButton >> defaultViewModel [

	^ ToButtonViewModel new
]

{ #category : #'api - orientation/direction' }
ToButton >> direction [

	^ self layout direction
]

{ #category : #'api - orientation/direction' }
ToButton >> direction: aBlLayoutDirection [

	self layout direction: aBlLayoutDirection
]

{ #category : #accessing }
ToButton >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToButton >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToButton >> iconImage [

	^ self viewModel iconImage
]

{ #category : #accessing }
ToButton >> iconImage: anElement [

	self viewModel iconImage: anElement
]

{ #category : #private }
ToButton >> iconImageReplaced [

	self privateUpdateChildren 
]

{ #category : #accessing }
ToButton >> iconViewModel: anImageViewModel [

	self privateIcon: anImageViewModel privateNewWidget.
	self privateIcon viewModel: anImageViewModel

]

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	labelFirst := true. 
	self
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ]
]

{ #category : #'api - orientation/direction' }
ToButton >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'api - orientation/direction' }
ToButton >> isLabelFirst [
	
	^ labelFirst
]

{ #category : #'api - orientation/direction' }
ToButton >> labelFirst [

	^ labelFirst
]

{ #category : #'api - orientation/direction' }
ToButton >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateChildren
]

{ #category : #accessing }
ToButton >> labelText: aText [

	self viewModel labelText: aText
]

{ #category : #private }
ToButton >> labelTextReplaced [

	self privateUpdateChildren 
]

{ #category : #accessing }
ToButton >> labelViewModel: aLabelViewModel [

	self privateLabel: aLabelViewModel privateNewWidget.
	self privateLabel viewModel: aLabelViewModel


]

{ #category : #'api - orientation/direction' }
ToButton >> orientation [

	^ self layout orientation
]

{ #category : #'api - orientation/direction' }
ToButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation
]

{ #category : #private }
ToButton >> privateIcon [

	^ icon
]

{ #category : #private }
ToButton >> privateIcon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon := anImage.
	icon ifNotNil: [ icon constraintsDo: [ :c | c linear vertical alignCenter ] ].
	self privateUpdateChildren 
	
]

{ #category : #private }
ToButton >> privateLabel [

	^ label
]

{ #category : #private }
ToButton >> privateLabel: aLabel [

	label = aLabel ifTrue: [ ^ self ].
	label := aLabel.
	label ifNotNil: [ label constraintsDo: [ :c | c linear vertical alignCenter ] ].
	self privateUpdateChildren 
	
]

{ #category : #private }
ToButton >> privateUpdateChildren [

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
ToButton >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToButton >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #enumerating }
ToButton >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self viewModel whenActionPerformedDo: aBlock
]
