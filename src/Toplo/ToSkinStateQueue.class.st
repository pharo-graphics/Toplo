Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'nextStates'
	],
	#category : 'Toplo-Core-Theme'
}

{ #category : #hook }
ToSkinStateQueue >> applyOn: anElement [

	| nextInQueue |
	[ (nextInQueue := self nextStates nextOrNil) isNotNil ] whileTrue: [
		nextInQueue applyOn: anElement ]
]

{ #category : #adding }
ToSkinStateQueue >> enqueueState: aState for: anElement [

	self nextStates nextPut: aState.
	aState onEnqueuedFor: anElement
]

{ #category : #hook }
ToSkinStateQueue >> flushStates: aBlock [

	self nextStates flush: aBlock
]

{ #category : #initialization }
ToSkinStateQueue >> initialize [ 

	super initialize.
	nextStates := WaitfreeQueue new
]

{ #category : #accessing }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : #initialization }
ToSkinStateQueue >> skinInitialStateRequest: anEvent [
	" initial state required - if the element is enabled proceed with stored persistent states "

	| target |
	target := anEvent currentTarget.
	self enqueueState: ToInitialState new for: target.
	" restitute the intrasic states (as enablement, check, selection)"
	target skinManager intrinsicStatesDo: [ :state |
		self enqueueState: state for: target ].

]

{ #category : #initialization }
ToSkinStateQueue >> skinInstallStateRequest: anEvent [
	" install state required  "

	| target |
	target := anEvent currentTarget.
	self enqueueState: ToInstallState new for: target
]

{ #category : #initialization }
ToSkinStateQueue >> skinUninstallStateRequest: anEvent [
	" uninstall state required  "

	| target |
	target := anEvent currentTarget.
	" have to ignore previous look events to avoid to apply them to the new skin"
	self nextStates flush.
	" store the uninstall state "
	self enqueueState: ToUninstallState new for: target
]
