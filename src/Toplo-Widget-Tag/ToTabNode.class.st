Class {
	#name : #ToTabNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - bar node' }
ToTabNode >> autoDistribute: aBoolean [

	super autoDistribute: aBoolean.
	aBoolean ifTrue: [
		self tab constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #skin }
ToTabNode >> newRawSkin [ 

	^ ToTabNodeSkin new
]

{ #category : #'as yet unclassified' }
ToTabNode >> tab [

	^ self firstChild
]

{ #category : #'as yet unclassified' }
ToTabNode >> tab: aTabButton [

	aTabButton ifNil: [ ^ self ].
	aTabButton parent = self ifTrue: [ ^ self ].
	aTabButton removeFromParent.
	self addChild: aTabButton
]
