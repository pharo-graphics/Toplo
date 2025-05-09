Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToRemovableItem',
	#classTraits : 'TToRemovableItem classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabItemElement >> applyWidgetConfiguration [

	| listElement |
	super applyWidgetConfiguration.
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

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]
