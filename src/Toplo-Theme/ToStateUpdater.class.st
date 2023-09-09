Class {
	#name : #ToStateUpdater,
	#superclass : #Object,
	#instVars : [
		'applyBlock'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToStateUpdater >> applyBlock [

	^ applyBlock
]

{ #category : #accessing }
ToStateUpdater >> applyBlock: anObject [

	applyBlock := anObject
]

{ #category : #operating }
ToStateUpdater >> applyOn: anElement fromLook: aLook [
	| doer |
	doer := self applyBlock ifNil: [ aLook applyBlock ].
	^ doer value: anElement
]

{ #category : #accessing }
ToStateUpdater >> applyWith: aBlock [

	" aBlock takes 2 args: the element and the property value "
	applyBlock := aBlock
]

{ #category : #converting }
ToStateUpdater >> asStateUpdater [

	^ self
]
