Class {
	#name : #ToStateUpdaterDep,
	#superclass : #Object,
	#instVars : [
		'applyBlock'
	],
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #testing }
ToStateUpdaterDep class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
ToStateUpdaterDep >> applyBlock [

	^ applyBlock
]

{ #category : #accessing }
ToStateUpdaterDep >> applyBlock: anObject [

	applyBlock := anObject
]

{ #category : #operating }
ToStateUpdaterDep >> applyOn: anElement fromLook: aLook [
	| doer |
	doer := self applyBlock ifNil: [ aLook applyBlock ].
	^ doer value: anElement
]

{ #category : #accessing }
ToStateUpdaterDep >> applyWith: aBlock [

	" aBlock takes 2 args: the element and the property value "
	applyBlock := aBlock
]

{ #category : #converting }
ToStateUpdaterDep >> asStateUpdater [

	^ self
]
