Class {
	#name : #ToStateValueDep,
	#superclass : #ToStateUpdaterDep,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #testing }
ToStateValueDep class >> isDeprecated [ 

	^ true
]

{ #category : #operating }
ToStateValueDep >> applyOn: anElement fromLook: aLook [

	| doer |
	doer := self applyBlock ifNil: [ aLook applyBlock ].
	^ doer value: anElement value: (self valueIn: anElement)
]

{ #category : #converting }
ToStateValueDep >> asStateUpdater [ 

	Error signal: 'Only valuable can be converted as an updater'
]

{ #category : #converting }
ToStateValueDep >> asStateValue [

	^ self
]

{ #category : #accessing }
ToStateValueDep >> value: anObject [

	value := anObject
]

{ #category : #accessing }
ToStateValueDep >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]
