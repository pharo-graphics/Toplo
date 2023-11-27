Class {
	#name : 'ToSkinStateQueue',
	#superclass : 'Object',
	#instVars : [
		'nextStates'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinStateQueue >> applyOn: anElement [

	| nextInQueue |
	[ (nextInQueue := self nextStates nextOrNil) isNotNil ] whileTrue: [
		nextInQueue applyOn: anElement ]
]

{ #category : 'adding' }
ToSkinStateQueue >> enqueueState: aState for: anElement [

	self nextStates nextPut: aState.
	aState onEnqueuedFor: anElement
]

{ #category : 'hook' }
ToSkinStateQueue >> flushStates: aBlock [

	self nextStates flush: aBlock
]

{ #category : 'initialization' }
ToSkinStateQueue >> initialize [ 

	super initialize.
	nextStates := WaitfreeQueue new
]

{ #category : 'accessing' }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : 'initialization' }
ToSkinStateQueue >> skinInstallStateRequestIn: anElement [
	" install state required  "

	self enqueueState: ToInstallState new for: anElement.
	" restitute the intrasic states (as enablement, check)
	enablement state must always be the last one to be enqueued "
	anElement skinManager intrinsicStatesDo: [ :state |
		self enqueueState: state for: anElement ]
]

{ #category : 'initialization' }
ToSkinStateQueue >> skinUninstallStateRequestIn: anElement [
	" uninstall state required  "

	" have to ignore previous look events to avoid to apply them to the new skin"
	self nextStates flush.
	" store the uninstall state "
	self enqueueState: ToUninstallState new for: anElement
]
