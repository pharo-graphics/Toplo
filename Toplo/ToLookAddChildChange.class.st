Class {
	#name : #ToLookAddChildChange,
	#superclass : #ToLookPropertyChange,
	#instVars : [
		'child'
	],
	#category : #'Toplo-Core-Changes'
}

{ #category : #initialization }
ToLookAddChildChange >> containerOn: aLook [

	path
		ifEmpty: [ ^ aLook widget ].
	
	self flag: 'ugly hack around widgetContent'.
	^ path first = #content
		ifTrue: [ path size >= 2
				ifTrue: [ (path copyFrom: 2 to: path size)
						inject: aLook widgetContent
						into: [ :e :f | e childNamed: f ] ]
				ifFalse: [ aLook widget ] ]
		ifFalse: [ (path copyFrom: 1 to: path size)
				inject: aLook widget
				into: [ :e :f | e childNamed: f ] ]
]

{ #category : #printing }
ToLookAddChildChange >> printOn: aStream [
	aStream nextPutAll: 'add child '.
	super printOn: aStream
]

{ #category : #initialization }
ToLookAddChildChange >> readOn: aLook [
	^ child
]

{ #category : #initialization }
ToLookAddChildChange >> writeOn: aLook value: anObject [
	| container |
	container := self containerOn: aLook.
	^ anObject
		ifNil: [ container removeChild: child ]
		ifNotNil: [ child := anObject.
			container addChild: anObject ]
]
