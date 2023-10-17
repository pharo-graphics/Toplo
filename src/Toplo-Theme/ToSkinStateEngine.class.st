Class {
	#name : 'ToSkinStateEngine',
	#superclass : 'Object',
	#instVars : [
		'currentStates',
		'nextStates'
	],
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'removing' }
ToSkinStateEngine >> addSkinState: aState [

	self currentStates removeAllSuchThat: [ :s |
		aState incompatibleStateClasses includes: s class ].
	self addSkinState: aState in: self nextStates.
	aState isPersistent ifTrue: [
		self addSkinState: aState in: self currentStates ]
]

{ #category : 'removing' }
ToSkinStateEngine >> addSkinState: aState in: aStateFifo [

	aStateFifo removeAllSuchThat: [ :s | s isKindOf: aState class ].
	aStateFifo addFirst: aState
]

{ #category : 'hook' }
ToSkinStateEngine >> applyOn: anElement [

	[ self nextStates isEmpty ] whileFalse: [
		self nextStates removeLast applyOn: anElement ]
]

{ #category : 'accessing' }
ToSkinStateEngine >> currentStates [

	^ currentStates
]

{ #category : 'initialization' }
ToSkinStateEngine >> initialize [ 

	super initialize.
	currentStates := LinkedList new.
	nextStates := LinkedList new
]

{ #category : 'accessing' }
ToSkinStateEngine >> nextStates [

	^ nextStates
]

{ #category : 'initialization' }
ToSkinStateEngine >> reset [

	nextStates := LinkedList new
]
