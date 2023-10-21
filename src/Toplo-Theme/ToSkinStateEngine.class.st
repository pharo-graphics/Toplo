Class {
	#name : 'ToSkinStateEngine',
	#superclass : 'Object',
	#instVars : [
		'currentStates',
		'nextStates',
		'installed'
	],
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'removing' }
ToSkinStateEngine >> addSkinState: aState [

	" remove incompatible state from next states fifo "
	self cleanUpFifo: self nextStates forSkinState: aState.

	" add a state to be apply with #applyOn: by the space SkinStatePhase "
	self nextStates addFirst: aState.

	" remove incompatible state from current states (persistent) fifo "
	self cleanUpFifo: self currentStates forSkinState: aState.
	
	" then store persistent  state to be re-applied when a new initial state is required (see switchToInstallState:in:)"
	aState isPersistent ifTrue: [ self currentStates addFirst: aState ]
]

{ #category : 'removing' }
ToSkinStateEngine >> addSkinState: aState in: anElement [

	" declare the element as dirty "
	anElement spaceDo: [ :space | space elementWithUnappliedStates: anElement ].
	self addSkinState: aState
]

{ #category : 'hook' }
ToSkinStateEngine >> applyOn: anElement [

	[ self nextStates isEmpty ] whileFalse: [
		self nextStates removeLast applyOn: anElement ]
]

{ #category : 'removing' }
ToSkinStateEngine >> cleanUpFifo: aStateFifo forSkinState: aState [

	aStateFifo removeAllSuchThat: [ :s | s isKindOf: aState class ].
	aStateFifo removeAllSuchThat: [ :s |
		aState incompatibleStateClasses includes: s class ]
]

{ #category : 'accessing' }
ToSkinStateEngine >> currentStates [

	^ currentStates
]

{ #category : 'initialization' }
ToSkinStateEngine >> initialize [ 

	super initialize.
	currentStates := LinkedList new.
	nextStates := LinkedList new.
	installed := false
]

{ #category : 'accessing' }
ToSkinStateEngine >> nextStates [

	^ nextStates
]

{ #category : 'api - hooks' }
ToSkinStateEngine >> onInstalledIn: anElement [


]

{ #category : 'api - hooks' }
ToSkinStateEngine >> onUninstalledIn: anElement [


]

{ #category : 'initialization' }
ToSkinStateEngine >> refreshStateEvent: anEvent [ 
	" initial state required - if the element is enabled proceed with stored persistent states "

	installed ifFalse: [
		^ self
			  switchToInstallState: (ToInstallState sourceEvent: anEvent)
			  in: anEvent currentTarget ].
	self switchToInitialStateEvent: anEvent in: anEvent currentTarget
]

{ #category : 'accessing' }
ToSkinStateEngine >> reinstall [

	installed := false

	
]

{ #category : 'initialization' }
ToSkinStateEngine >> reset [

	nextStates := LinkedList new.
	installed := false
]

{ #category : 'initialization' }
ToSkinStateEngine >> switchToInitialStateEvent: anEvent in: anElement [
	" initial state required - if the element is enabled proceed with stored persistent states "

	installed ifFalse: [ Error signal: 'An InitialSate before an InstallState as been applied' ].
	" FIFO management of states list "
	" initial is applied first "
	self addSkinState: (ToInitialState sourceEvent: anEvent) in: anElement.
	anElement isEnabled
		ifTrue: [
			self addSkinState: (ToEnabledState sourceEvent: anEvent).
			self currentStates do: [ :s | self addSkinState: s ] ]
		ifFalse: [ " when disabled, do not reinstall stored perssistent states "
			self addSkinState: (ToDisabledState sourceEvent: anEvent) ]
]

{ #category : 'initialization' }
ToSkinStateEngine >> switchToInstallState: anInstallState in: anElement [
	" install state required - if the element is enabled proceed with stored persistent states "

	" FIFO management of states list "

	installed ifTrue: [
		^ Error signal: 'InstallState has already been applied' ].

	" install state is used only once "
	self addSkinState: anInstallState in: anElement.
	installed := true.
	self
		switchToInitialStateEvent: anInstallState sourceEvent
		in: anElement
]
