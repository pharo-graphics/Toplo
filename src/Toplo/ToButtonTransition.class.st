Class {
	#name : #ToButtonTransition,
	#superclass : #Object,
	#instVars : [
		'name',
		'exitAnimation',
		'enterAnimation'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #converting }
ToButtonTransition >> asToButtonTransition [

	^ self
]

{ #category : #accessing }
ToButtonTransition >> enterAnimation [

	^ enterAnimation
]

{ #category : #accessing }
ToButtonTransition >> enterAnimation: anAnimation [

	enterAnimation := anAnimation
]

{ #category : #accessing }
ToButtonTransition >> exitAnimation [

	^ exitAnimation
]

{ #category : #accessing }
ToButtonTransition >> exitAnimation: anAnimation [

	exitAnimation := anAnimation
]

{ #category : #accessing }
ToButtonTransition >> name [

	^ name
]

{ #category : #accessing }
ToButtonTransition >> name: anObject [

	name := anObject
]
