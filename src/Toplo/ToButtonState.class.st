Class {
	#name : #ToButtonState,
	#superclass : #Object,
	#instVars : [
		'labelText',
		'iconImage',
		'name'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #hook }
ToButtonState >> applyOn: aToButton [

	iconImage ifNotNil: [ aToButton iconImage: iconImage ].
	labelText ifNotNil: [ aToButton labelText: labelText ]
]

{ #category : #accessing }
ToButtonState >> iconImage [

	^ iconImage
]

{ #category : #accessing }
ToButtonState >> iconImage: anElement [

	iconImage := anElement
]

{ #category : #accessing }
ToButtonState >> labelText [

	^ labelText
]

{ #category : #accessing }
ToButtonState >> labelText: aText [

	labelText := aText
]

{ #category : #accessing }
ToButtonState >> name [

	^ name
]

{ #category : #accessing }
ToButtonState >> name: anObject [

	name := anObject
]
