Class {
	#name : #ToTabNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-Tag-Tab'
}

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
