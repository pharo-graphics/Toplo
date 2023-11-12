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
	target isEnabled
		ifTrue: [
			self enqueueState: (ToEnabledState sourceEvent: anEvent) for: target.
			"self currentStates do: [ :s | self enqueueState: s for: target]" ]
		ifFalse: [ " if disabled, do not reinstall persistent states "
			self enqueueState: (ToDisabledState sourceEvent: anEvent) for: target]
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
	self nextStates flush.
	self enqueueState: (ToUninstallState sourceEvent: anEvent) for: target
]
