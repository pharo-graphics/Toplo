Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'currentStates',
		'nextStates',
		'installed'
	],
	#category : 'Toplo-Theme-State'
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

	self nextStates removeAllSuchThat: [ :s | (s isKindOf: aState class) or: [ aState incompatibleStateClasses includes: s class ]].
	self nextStates addFirst: aState.
	" then store persistent  state to be re-applied when a new install state is required (see switchToInstallState:in:)"
	self currentStates removeAllSuchThat: [ :s | (s isKindOf: aState class) or: [ aState incompatibleStateClasses includes: s class ]].
	aState isPersistent ifFalse: [ ^ self ].
	self currentStates addFirst: aState
]

{ #category : #adding }
ToSkinStateQueue >> enqueueState: aState in: anElement [

	self enqueueState: aState.
	" declare the element as dirty "
	anElement spaceDo: [ :space | space requestSkinApplicationFor: anElement ].

]

{ #category : #initialization }
ToSkinStateQueue >> initialize [ 

	super initialize.
	self reset
]

{ #category : #accessing }
ToSkinStateQueue >> installed [

	^ installed 
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

{ #category : #accessing }
ToSkinStateQueue >> reinstall [

	installed := false

	
]

{ #category : #initialization }
ToSkinStateQueue >> reset [ 

	currentStates := LinkedList new.
	nextStates := LinkedList new.
	installed := false
]

{ #category : #initialization }
ToSkinStateQueue >> skinInitialStateRequest: anEvent [
	" initial state required - if the element is enabled proceed with stored persistent states "

	| target |
	installed ifFalse: [ Error signal: 'The skin must be installed first' ].
	target := anEvent currentTarget.
	self enqueueState: (ToInitialState sourceEvent: anEvent) in: target.
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
	installed := true.
	self enqueueState: (ToInstallState sourceEvent: anEvent) in: target
]
