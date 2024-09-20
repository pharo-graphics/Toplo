Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'nextStates',
		'previousInstallState',
		'intrinsicStateIndex'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #hook }
ToSkinStateQueue >> applyEnqueuedStatesIn: anElement [

	nextStates do: [ :nextInQueue | 
		nextInQueue applyOn: anElement ].
	nextStates reset
]

{ #category : #hook }
ToSkinStateQueue >> applyOn: anElement [

	self
		deprecated: 'Use applyEnqueuedStatesIn: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyEnqueuedStatesIn: `@argument'.

	self applyEnqueuedStatesIn: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueEnablementStateForElement: anElement [

	" restitute the intrasic states (as enablement, check)
	enablement state must always be the last one to be enqueued "
	self intrinsicStatesDo: [ :state |
		self enqueueState: state for: anElement ].
	self
		enqueueState: (ToEnablementState new enabled: anElement isEnabled)
		for: anElement.

	
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

	nextStates add: aState.
	anElement spaceDo: [ :sp |
		sp needSkinStateApplicationPass: true ]
]

{ #category : #adding }
ToSkinStateQueue >> enqueueUninstallStateForElement: anElement [
	" uninstall state required  "

	" have to ignore previous look events to avoid to apply them to the new skin"
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
	nextStates := OrderedCollection new.
	" Use an ordered dictionary for intrinsicStateIndex to ensure that an 
	EnableState is always the last state "
	intrinsicStateIndex := OrderedIdentityDictionary new
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
