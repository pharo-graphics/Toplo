Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToShrinkable + TToRemovableItem',
	#classTraits : 'TToShrinkable classTrait + TToRemovableItem classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabItemElement >> applyWidgetConfiguration [

	| listElement shrinkLayer |
	super applyWidgetConfiguration.
	shrinkLayer := self childWithId: #shrinkFeedbackLayer ifNone: [  ].
	shrinkLayer ifNotNil: [ shrinkLayer shrinked: self middleContainer ].
	listElement := self holder listElement.
	(listElement isVertical and: [ listElement atStartSide not ])
		ifTrue: [
			self startFlexible: true.
			self endFlexible: false ]
		ifFalse: [
			self startFlexible: false.
			self endFlexible: true ]
]

{ #category : #converting }
ToTabItemElement >> asToLabelText [ 

	^ self label asToLabelText
]

{ #category : #initialization }
ToTabItemElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self addShrinkFeedbackLayer
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]
