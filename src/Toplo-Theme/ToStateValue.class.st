Class {
	#name : #ToStateValue,
	#superclass : #ToStateUpdater,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #operating }
ToStateValue >> applyOn: anElement fromLook: aLook [

	| doer |
	doer := self applyBlock ifNil: [ aLook applyBlock ].
	^ doer value: anElement value: (self valueIn: anElement)
]

{ #category : #converting }
ToStateValue >> asStateUpdater [ 

	Error signal: 'A value can''t be converted as an updater'
]

{ #category : #converting }
ToStateValue >> asStateValue [

	^ self
]

{ #category : #accessing }
ToStateValue >> value: anObject [

	value := anObject
]

{ #category : #accessing }
ToStateValue >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]
