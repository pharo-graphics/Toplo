Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'nextStates',
		'previousInstallState',
		'intrinsicStateIndex',
		'installStateApplied'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'state application' }
ToSkinStateQueue >> applyEnqueuedStatesIn: anElement [

	nextStates do: [ :nextInQueue | 
		nextInQueue applyOn: anElement fromQueue: self ].
	nextStates reset
]

{ #category : #'state application' }
ToSkinStateQueue >> applyOn: anElement [

	self
		deprecated: 'Use applyEnqueuedStatesIn: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyEnqueuedStatesIn: `@argument'.

	self applyEnqueuedStatesIn: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enablementChangedIn: anElement [
	" Do not force state application if the element is not in a space.
	It can also be the case when a layout is computed for an infinite "

	(anElement isAttachedToSceneGraph not or: [ installStateApplied not ])
		ifTrue: [ ^ anElement requestNewSkin ].
	nextStates reset.
	self enqueueEnablementStateForElement: anElement.
	self applyEnqueuedStatesIn: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueEnablementStateForElement: anElement [
	" restitute the intrasic states (as enablement, check)
	enablement state must always be the first one for an enabled element, 
	it must be the last one to be enqueued for a disabled element  "

	anElement isEnabled ifTrue: [
		self
			enqueueState: (ToEnablementState new enabled: true)
			for: anElement ].

	self intrinsicStatesDo: [ :state |
		self enqueueState: state for: anElement ].

	anElement isEnabled ifFalse: [
		self
			enqueueState: (ToEnablementState new enabled: false)
			for: anElement ]
]

{ #category : #adding }
ToSkinStateQueue >> enqueueInstallStateForElement: anElement [
	" install state required  "
	
	previousInstallState := ToInstallState new.
	self enqueueState: previousInstallState for: anElement.
	self enqueueEnablementStateForElement: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueState: aState for: anElement [
	" all states kinds are enqueued here "

	(anElement isPreventedSkinEvent: aState skinEvent) ifTrue: [ ^ self ].
	nextStates add: aState.
	anElement spaceDo: [ :sp | sp needSkinStateApplicationPass: true ]
]

{ #category : #adding }
ToSkinStateQueue >> enqueueUninstallStateForElement: anElement [
	" uninstall state required  "

	" have to ignore previous skin events to avoid to apply them to the new skin"
	nextStates reset.
	previousInstallState := nil.
	" store the uninstall state "
	self enqueueState: ToUninstallState new for: anElement
]

{ #category : #accessing }
ToSkinStateQueue >> hasInstallStateEnqueued [

	^ previousInstallState notNil
]

{ #category : #initialization }
ToSkinStateQueue >> initialize [ 

	super initialize.
	installStateApplied := false.
	nextStates := OrderedCollection new.
	" Use an ordered dictionary for intrinsicStateIndex to ensure that an 
	EnableState is always the last state "
	intrinsicStateIndex := OrderedIdentityDictionary new
]

{ #category : #'state application' }
ToSkinStateQueue >> installStateApplied: aBoolean [

	installStateApplied := aBoolean
]

{ #category : #'intrinsic states' }
ToSkinStateQueue >> intrinsicStatesDo: aBlock [

	intrinsicStateIndex valuesDo: aBlock
]

{ #category : #accessing }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : #'intrinsic states' }
ToSkinStateQueue >> onIntrinsicStateEnqueueRequested: aState [

	intrinsicStateIndex at: aState class put: aState
]
