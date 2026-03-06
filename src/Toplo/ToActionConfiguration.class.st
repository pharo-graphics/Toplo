Class {
	#name : #ToActionConfiguration,
	#superclass : #ToWidgetConfiguration,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Configuration'
}

{ #category : #accessing }
ToActionConfiguration class >> action: aBlockWithOneOptArg [

	^ self new action: aBlockWithOneOptArg
]

{ #category : #accessing }
ToActionConfiguration >> action: aBlock [
	" aBlock take the element as optional argument "

	action := aBlock
]

{ #category : #hook }
ToActionConfiguration >> applyOn: anElement [

	super applyOn: anElement.
	action cull: anElement
]

{ #category : #initialization }
ToActionConfiguration >> initialize [

	super initialize.
	action := [ :optionalThisElement | ]
]
