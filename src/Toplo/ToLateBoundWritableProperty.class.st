Class {
	#name : #ToLateBoundWritableProperty,
	#superclass : #ToWritableProperty,
	#category : #'Toplo-Core-Properties'
}

{ #category : #operating }
ToLateBoundWritableProperty >> boundWith: anObject [

	^ anObject lookupWritablePropertyNamed: self name
]

{ #category : #operating }
ToLateBoundWritableProperty >> read: anObject [

	^ (self boundWith: anObject) read: anObject
]

{ #category : #operating }
ToLateBoundWritableProperty >> write: anPropertyValue to: anObject [

	(self boundWith: anObject) write: anPropertyValue to: anObject.
	^ anObject
]
