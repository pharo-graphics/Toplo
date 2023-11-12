Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'currentStates',
		'nextStates'
	],
	#category : 'Toplo-Core-Theme'
}

{ #category : #hook }
ToSkinStateQueue >> applyOn: anElement [

	[ self nextStates isEmpty ] whileFalse: [
		self nextStates removeLast applyOn: anElement ]
]

{ #category : #accessing }
ToSkinStateQueue >> currentStates [

	^ currentStates
]

{ #category : #adding }
ToSkinStateQueue >> enqueueState: aState for: anElement [

	self nextStates removeAllSuchThat: [ :s |
		(s isKindOf: aState class) or: [
			aState incompatibleStateClasses anySatisfy: [ :cls |
				s isKindOf: cls ] ] ].
	self nextStates addFirst: aState.
	" then store persistent  state to be re-applied when a new install state is required (see switchToInstallState:in:)"
	self currentStates removeAllSuchThat: [ :s |
		(s isKindOf: aState class) or: [
			aState incompatibleStateClasses anySatisfy: [ :cls |
				s isKindOf: cls ] ] ].
	aState isPersistent ifFalse: [ ^ self ].
	self currentStates addFirst: aState
]

{ #category : #initialization }
ToSkinStateQueue >> initialize [ 

	super initialize.
	currentStates := LinkedList new.
	nextStates := LinkedList new
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
	self enqueueState: (ToInitialState sourceEvent: anEvent) for: target.
	target isEnabled
		ifTrue: [
			self enqueueState: (ToEnabledState sourceEvent: anEvent) for: target.
			self currentStates do: [ :s | self enqueueState: s for: target] ]
		ifFalse: [ " if disabled, do not reinstall persistent states "
			self enqueueState: (ToDisabledState sourceEvent: anEvent) for: target]
]

{ #category : #initialization }
ToSkinStateQueue >> skinInstallStateRequest: anEvent [
	" install state required  "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToInstallState sourceEvent: anEvent) for: target
]

{ #category : #initialization }
ToSkinStateQueue >> skinUninstallStateRequest: anEvent [
	" uninstall state required  "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToUninstallState sourceEvent: anEvent) for: target
]
