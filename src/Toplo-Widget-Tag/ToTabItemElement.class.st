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

{ #category : #converting }
ToTabItemElement >> asToLabelText [ 

	^ self label asToLabelText
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]
