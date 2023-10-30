Class {
	#name : 'ToSkinStateQueue',
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

{ #category : 'hook' }
ToSkinStateQueue >> applyOn: anElement [

	[ self nextStates isEmpty ] whileFalse: [
		self nextStates removeLast applyOn: anElement ]
]

{ #category : 'accessing' }
ToSkinStateQueue >> currentStates [

	^ currentStates
]

{ #category : 'adding' }
ToSkinStateQueue >> enqueueState: aState [

	self nextStates removeAllSuchThat: [ :s | (s isKindOf: aState class) or: [ aState incompatibleStateClasses includes: s class ]].
	self nextStates addFirst: aState.
	" then store persistent  state to be re-applied when a new install state is required (see switchToInstallState:in:)"
	self currentStates removeAllSuchThat: [ :s | (s isKindOf: aState class) or: [ aState incompatibleStateClasses includes: s class ]].
	aState isPersistent ifFalse: [ ^ self ].
	self currentStates addFirst: aState
]

{ #category : 'adding' }
ToSkinStateQueue >> enqueueState: aState in: anElement [

	" declare the element as dirty "
	anElement spaceDo: [ :space | space elementWithUnappliedStates: anElement ].
	self enqueueState: aState
]

{ #category : 'initialization' }
ToSkinStateQueue >> initialize [ 

	super initialize.
	currentStates := LinkedList new.
	nextStates := LinkedList new.
	installed := false
]

{ #category : 'accessing' }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : 'api - hooks' }
ToSkinStateQueue >> onInstalledIn: anElement [


]

{ #category : 'api - hooks' }
ToSkinStateQueue >> onUninstalledIn: anElement [


]

{ #category : 'initialization' }
ToSkinStateQueue >> refreshStateEvent: anEvent [ 
	" initial state required - if the element is enabled proceed with stored persistent states "

	installed ifFalse: [
		^ self
			  switchToInstallState: (ToInstallState sourceEvent: anEvent)
			  in: anEvent currentTarget ].
	self switchToInitialStateEvent: anEvent in: anEvent currentTarget
]

{ #category : 'accessing' }
ToSkinStateQueue >> reinstall [

	installed := false

	
]

{ #category : 'initialization' }
ToSkinStateQueue >> reset [

	nextStates := LinkedList new.
	installed := false
]

{ #category : 'initialization' }
ToSkinStateQueue >> switchToInitialStateEvent: anEvent in: anElement [
	" initial state required - if the element is enabled proceed with stored persistent states "

	installed ifFalse: [ Error signal: 'An InitialSate before an InstallState as been applied' ].
	" FIFO management of states list "
	" initial is applied first "
	self enqueueState: (ToInitialState sourceEvent: anEvent) in: anElement.
	anElement isEnabled
		ifTrue: [
			self enqueueState: (ToEnabledState sourceEvent: anEvent).
			self currentStates do: [ :s | self enqueueState: s ] ]
		ifFalse: [ " when disabled, do not reinstall persistent states "
			self enqueueState: (ToDisabledState sourceEvent: anEvent) ]
]

{ #category : 'initialization' }
ToSkinStateQueue >> switchToInstallState: anInstallState in: anElement [
	" install state required - if the element is enabled proceed with stored persistent states "

	" FIFO management of states list "

	installed ifTrue: [
		^ Error signal: 'InstallState has already been applied' ].

	" install state is used only once "
	self reset.
	self enqueueState: anInstallState in: anElement.
	installed := true.
	self
		switchToInitialStateEvent: anInstallState sourceEvent
		in: anElement
]