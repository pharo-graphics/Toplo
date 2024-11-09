Class {
	#name : #ToSkinStateMouseEventProcessManager,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'process',
		'skinStateGenerator'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #testing }
ToSkinStateMouseEventProcessManager >> canStartProcess [

	self target isEnabled ifFalse: [ ^ false ].
	self target space ifNil: [ ^ false ].
	self startDelay ifNil: [ ^ false ].
	^ true
]

{ #category : #'starting - stopping' }
ToSkinStateMouseEventProcessManager >> checkEvent: anEvent [

	self subclassResponsibility 
]

{ #category : #'state generating' }
ToSkinStateMouseEventProcessManager >> generateStartStateFromEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			skinStateGenerator enqueueTransientStateFromSkinEvent:
				(self startStateSkinEventClass sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'state generating' }
ToSkinStateMouseEventProcessManager >> generateStateFromEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			skinStateGenerator enqueueTransientStateFromSkinEvent:
				(self stateSkinEventClass sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'state generating' }
ToSkinStateMouseEventProcessManager >> generateStopStateFromEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			skinStateGenerator enqueueTransientStateFromSkinEvent:
				(self stopStateSkinEventClass sourceEvent: anEvent) ]
		for: self target
]

{ #category : #initialization }
ToSkinStateMouseEventProcessManager >> initialize [ 

	super initialize.
	mutex := Mutex new
]

{ #category : #'starting - stopping' }
ToSkinStateMouseEventProcessManager >> mainLoopFromEvent: anEvent [

	| targetPos |
	targetPos := self target bounds inSpace bounds position.
	[
	| space |
	space := self target space.
	space notNil and: [
		space isOpened and: [
			anEvent isConsumed not and: [
				self target bounds inSpace bounds position = targetPos ] ] ] ]
		whileTrue: [
			self generateStateFromEvent: anEvent.
			(Delay forMilliseconds: 10) wait ]
]

{ #category : #accessing }
ToSkinStateMouseEventProcessManager >> skinStateGenerator: aSkinStateGenerator [

	skinStateGenerator := aSkinStateGenerator
]

{ #category : #accessing }
ToSkinStateMouseEventProcessManager >> startDelay [

	^ self subclassResponsibility 
]

{ #category : #'starting - stopping' }
ToSkinStateMouseEventProcessManager >> startProcessFromEvent: anEvent [

	self canStartProcess ifFalse: [ ^ self ].
	process ifNotNil: [ ^ self ].
	process := [
	           self startDelay asDelay wait.
	           self generateStartStateFromEvent: anEvent.
	           self mainLoopFromEvent: anEvent copy.
	           self generateStopStateFromEvent: anEvent ] newProcess.

	process name: self class name , ' process'.
	process priority: Processor userBackgroundPriority.
	process resume
]

{ #category : #'state generating' }
ToSkinStateMouseEventProcessManager >> startStateSkinEventClass [

	^ self subclassResponsibility
]

{ #category : #'state generating' }
ToSkinStateMouseEventProcessManager >> stateSkinEventClass [

	^ self subclassResponsibility
]

{ #category : #'starting - stopping' }
ToSkinStateMouseEventProcessManager >> stopProcessFromEvent: anEvent [

	process ifNil: [ ^ self ].
	mutex critical: [
			process terminate.
			process := nil.
			self generateStopStateFromEvent: anEvent ] 
]

{ #category : #'state generating' }
ToSkinStateMouseEventProcessManager >> stopStateSkinEventClass [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToSkinStateMouseEventProcessManager >> target [ 

	^ skinStateGenerator target
]
