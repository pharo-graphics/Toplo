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

	" add a state to apply later with #applyOn:"
	self addSkinState: aState in: self nextStates.
	
	" then store the state to be re-applied when a new install state is required (see switchToInstallState:in:)"
	aState isPersistent ifTrue: [
		self addSkinState: aState in: self currentStates ]
]

{ #category : 'removing' }
ToSkinStateEngine >> addSkinState: aState in: aStateFifo [

	aStateFifo removeAllSuchThat: [ :s | s isKindOf: aState class ].
	aStateFifo removeAllSuchThat: [ :s |
		aState incompatibleStateClasses includes: s class ].
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

{ #category : 'api - hooks' }
ToSkinStateEngine >> onInstalledIn: anElement [


]

{ #category : 'api - hooks' }
ToSkinStateEngine >> onUninstalledIn: anElement [


]

{ #category : 'initialization' }
ToSkinStateEngine >> reset [

	nextStates := LinkedList new
]

{ #category : 'initialization' }
ToSkinStateEngine >> switchToInstallState: anInstallState in: anElement [
	" install state required - if the element is enabled proceed with stored persistent states "

	" FIFO management of states list "
	self addSkinState: anInstallState.
	" initial is applied after install "
	self addSkinState:	(ToInitialState sourceEvent: anInstallState sourceEvent).
	anElement isEnabled
		ifTrue: [
			self addSkinState: (ToEnabledState sourceEvent: anInstallState sourceEvent).
			self currentStates do: [ :s | self addSkinState: s ] ]
		ifFalse: [ " when disabled, do not reinstall stored perssistent states "
			self addSkinState: (ToDisabledState sourceEvent: anInstallState sourceEvent) ]
]
