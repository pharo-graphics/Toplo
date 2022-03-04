Class {
	#name : #ToLookAddChildFirstChange,
	#superclass : #ToLookAddChildChange,
	#category : #'Toplo-Core-Changes'
}

{ #category : #initialization }
ToLookAddChildFirstChange >> writeOn: aLook value: anObject [
	| container |
	container := self containerOn: aLook.
	^ anObject
		ifNil: [ container removeChild: child ]
		ifNotNil: [ child := anObject.
			container addChildFirst: anObject ]
]
