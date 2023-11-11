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
ToSkinStateQueue >> enqueueState: aState [

	self nextStates removeAllSuchThat: [ :s | (s isKindOf: aState class) or: [ aState incompatibleStateClasses anySatisfy: [ :cls | s isKindOf: cls ]]].
	self nextStates addFirst: aState.
	" then store persistent  state to be re-applied when a new install state is required (see switchToInstallState:in:)"
	self currentStates removeAllSuchThat: [ :s | (s isKindOf: aState class) or: [ aState incompatibleStateClasses anySatisfy: [ :cls | s isKindOf: cls ]]].
	aState isPersistent ifFalse: [ ^ self ].
	self currentStates addFirst: aState
]

{ #category : #initialization }
ToSkinStateQueue >> initialize [ 

	super initialize.
	self reset
]

{ #category : #accessing }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : #'api - hooks' }
ToSkinStateQueue >> onInstalledIn: anElement [


]

{ #category : #'api - hooks' }
ToSkinStateQueue >> onUninstalledIn: anElement [


]

{ #category : #initialization }
ToSkinStateQueue >> reset [ 

	currentStates := LinkedList new.
	nextStates := LinkedList new
]

{ #category : #initialization }
ToSkinStateQueue >> skinInitialStateRequest: anEvent [
	" initial state required - if the element is enabled proceed with stored persistent states "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToInitialState sourceEvent: anEvent).
	target isEnabled
		ifTrue: [
			self enqueueState: (ToEnabledState sourceEvent: anEvent).
			self currentStates do: [ :s | self enqueueState: s ] ]
		ifFalse: [ " if disabled, do not reinstall persistent states "
			self enqueueState: (ToDisabledState sourceEvent: anEvent) ]
]

{ #category : #initialization }
ToSkinStateQueue >> skinInstallStateRequest: anEvent [
	" install state required  "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToInstallState sourceEvent: anEvent)
]

{ #category : #initialization }
ToSkinStateQueue >> skinUninstallStateRequest: anEvent [
	" uninstall state required  "

	| target |
	target := anEvent currentTarget.
	self enqueueState: (ToUninstallState sourceEvent: anEvent)
]
