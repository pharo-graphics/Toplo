Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToRemovableItem',
	#classTraits : 'TToRemovableItem classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-TabPane-TabBar'
}

{ #category : #converting }
ToTabItemElement >> asToLabelText [ 

	^ self label asToLabelText
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]

{ #category : #removing }
ToTabItemElement >> removeButton [ 

	^ self holder node removeButton
]

{ #category : #removing }
ToTabItemElement >> removeButtonDo: aValuable [

	self holder node removeButtonDo: aValuable 
]
