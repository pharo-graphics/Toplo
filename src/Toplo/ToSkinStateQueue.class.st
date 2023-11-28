Class {
	#name : 'ToSkinStateQueue',
	#superclass : 'Object',
	#instVars : [
		'nextStates',
		'previousInstallState',
		'intrinsicStateIndex'
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
	anElement spaceDo: [:sp | sp requestNextPulse ]
]

{ #category : 'adding' }
ToSkinStateQueue >> enqueueStateRequest: aState for: anElement [

	aState onEnqueueRequestFor: anElement inQueue: self
]

{ #category : 'hook' }
ToSkinStateQueue >> flushStates: aBlock [

	self nextStates flush: aBlock
]

{ #category : 'initialization' }
ToSkinStateQueue >> initialize [ 

	super initialize.
	nextStates := WaitfreeQueue new.
	" Use an ordered dictionary for intrinsicStateIndex to ensure that an 
	EnableState is always the last state "
	intrinsicStateIndex := OrderedIdentityDictionary new
]

{ #category : 'intrinsic states' }
ToSkinStateQueue >> intrinsicStatesDo: aBlock [

	intrinsicStateIndex valuesDo: aBlock
]

{ #category : 'accessing' }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : 'accessing' }
ToSkinStateQueue >> nextStates: anObject [

	nextStates := anObject
]

{ #category : 'intrinsic states' }
ToSkinStateQueue >> onIntrinsicStateEnqueueRequested: aState [

	intrinsicStateIndex at: aState class put: aState
]

{ #category : 'initialization' }
ToSkinStateQueue >> onSkinInstallStateRequestIn: anElement [
	" install state required  "

	previousInstallState := ToInstallState new.
	self enqueueStateRequest: previousInstallState for: anElement.
	
	" restitute the intrasic states (as enablement, check)
	enablement state must always be the last one to be enqueued "
	self intrinsicStatesDo: [ :state |
		self enqueueStateRequest: state for: anElement ]
]

{ #category : 'initialization' }
ToSkinStateQueue >> onSkinUninstallStateRequestIn: anElement [
	" uninstall state required  "

	" have to ignore previous look events to avoid to apply them to the new skin"
	self nextStates flush.
	previousInstallState := nil.
	" store the uninstall state "
	self enqueueStateRequest: ToUninstallState new for: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here "
	self applyOn: anElement
]

{ #category : 'accessing' }
ToSkinStateQueue >> previousInstallState [

	^ previousInstallState
]
