Class {
	#name : #ToAnchoredWindowElementForTest,
	#superclass : #ToElement,
	#traits : 'TToElementWithAssociateWindow',
	#classTraits : 'TToElementWithAssociateWindow classTrait',
	#instVars : [
		'window'
	],
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowElementForTest >> associateWindow [

	^ window
]

{ #category : #accessing }
ToAnchoredWindowElementForTest >> associateWindow: aWindow [

	window := aWindow
]
