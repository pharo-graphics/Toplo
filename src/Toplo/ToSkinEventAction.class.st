Class {
	#name : #ToSkinEventAction,
	#superclass : #ToSkinEventListener,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #visiting }
ToSkinEventAction >> accept: aVisitor [

	aVisitor visitSkinEventAction: self
]

{ #category : #accessing }
ToSkinEventAction >> action [

	^ action
]

{ #category : #accessing }
ToSkinEventAction >> action: aValuable [

	" aValuable takes an element as unique argument "
	action := aValuable
]

{ #category : #'look event handling' }
ToSkinEventAction >> applyOn: anObject withSkinEvent: aSkinEvent [

	self action cull: anObject cull: aSkinEvent
]

{ #category : #testing }
ToSkinEventAction >> isAction [

	^ true
]

{ #category : #testing }
ToSkinEventAction >> isSupplement [ 

	^ false
]

{ #category : #accessing }
ToSkinEventAction >> property [

	^ ToNullProperty uniqueInstance 
]
