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

{ #category : #'t - element with associate window - accessing' }
ToAnchoredWindowElementForTest >> associateWindow [

	^ window
]

{ #category : #'t - element with associate window - accessing' }
ToAnchoredWindowElementForTest >> associateWindow: aWindow [

	window := aWindow
]
