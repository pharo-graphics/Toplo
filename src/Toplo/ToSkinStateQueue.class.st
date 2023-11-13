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

	self nextStates nextPut: aState
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
ToSkinStateQueue >> skinInitialStateRequest: anEvent [
	" initial state required - if the element is enabled proceed with stored persistent states "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToInitialState sourceEvent: anEvent) for: target.
	self
		enqueueState: ((ToEnablementState sourceEvent: anEvent)
				 rawState: target isEnabled;
				 yourself)
		for: target
]

{ #category : 'initialization' }
ToSkinStateQueue >> skinInstallStateRequest: anEvent [
	" install state required  "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToInstallState sourceEvent: anEvent) for: target
]

{ #category : 'initialization' }
ToSkinStateQueue >> skinUninstallStateRequest: anEvent [
	" uninstall state required  "

	| target |
	target := anEvent currentTarget.
	" have to ignore previous look events to avoid to apply them to the new skin"
	self nextStates flush.
	" store the uninstall state "
	self enqueueState: (ToUninstallState sourceEvent: anEvent) for: target.
	" do not wait next pulse to send ToUninstallLookEvent to the current skin "
	self applyOn: target
]
