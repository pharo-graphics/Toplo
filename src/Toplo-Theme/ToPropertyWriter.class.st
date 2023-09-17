Class {
	#name : #ToPropertyWriter,
	#superclass : #Object,
	#traits : 'TToPropertyWriter',
	#classTraits : 'TToPropertyWriter classTrait',
	#instVars : [
		'property',
		'value',
		'animation'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #accessing }
ToPropertyWriter >> animation [

	^ animation
]

{ #category : #accessing }
ToPropertyWriter >> animation: aPropertyAnimation [

	animation := aPropertyAnimation
]

{ #category : #testing }
ToPropertyWriter >> canReplace: anotherWriter [

	^ false
]

{ #category : #accessing }
ToPropertyWriter >> property [

	^ property
]

{ #category : #accessing }
ToPropertyWriter >> property: anObject [

	property := anObject
]

{ #category : #accessing }
ToPropertyWriter >> value [

	^ value
]

{ #category : #accessing }
ToPropertyWriter >> value: aBlockOrObject [

	value := aBlockOrObject
]

{ #category : #operating }
ToPropertyWriter >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]

{ #category : #operating }
ToPropertyWriter >> valueWriter [

	^ self animation ifNil: [ self property ].
]

{ #category : #'t - property writer - writing' }
ToPropertyWriter >> writeTo: anElement [

	^ self valueWriter write: (self valueIn: anElement) to: anElement
]
