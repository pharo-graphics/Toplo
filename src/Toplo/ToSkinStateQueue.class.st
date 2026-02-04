Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'nextStates',
		'intrinsicState',
		'installState'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'state application' }
ToSkinStateQueue >> applyEnqueuedStatesFor: anElement [

	nextStates do: [ :nextInQueue | 
		nextInQueue applyOn: anElement fromQueue: self ].
	nextStates reset
]

{ #category : #'instinsic state accessing' }
ToSkinStateQueue >> checked: aBoolean for: anElement [

	intrinsicState checked: aBoolean.
	self enqueueIntrinsicStateFor: anElement
]

{ #category : #'instinsic state accessing' }
ToSkinStateQueue >> enabled: aBoolean for: anElement [

	intrinsicState enabled: aBoolean.
	self enqueueIntrinsicStateFor: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueInstallStateFor: anElement [

	installState ifNotNil: [ ^ ToInstallStateAlreadyQueuedError signal ].
	installState := ToInstallState instance.
	self enqueueState: installState for: anElement.
	intrinsicState enabled: anElement isEnabled.
	self enqueueIntrinsicStateFor: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueIntrinsicStateFor: anElement [
	" if an install state is not applied then don't enqueue it now,
	it will be enqueued properly on the next install state enqueuing "

	intrinsicState enqueued ifTrue: [ ^ self ].
	installState ifNil: [ ^ self ].
	self enqueueState: intrinsicState for: anElement.
	intrinsicState enqueued: true
]

{ #category : #adding }
ToSkinStateQueue >> enqueueState: aState for: anElement [

	nextStates add: aState.
	anElement spaceDo: [ :sp | sp requestSkinStateApplicationPass ]
]

{ #category : #adding }
ToSkinStateQueue >> enqueueTransientState: aState for: anElement [
	" if an install state is not applied then just ignore a transient state "

	installState ifNil: [ ^ self ].
	self enqueueState: aState for: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueUninstallStateFor: anElement [
	" uninstall state required  "

	installState ifNil: [ ^ ToInstallStateNotQueuedError signal ].
	" have to ignore previous skin events to avoid to apply them to the new skin"
	nextStates reset.
	installState := nil.
	intrinsicState enqueued: false.
	" store the uninstall state "
	self enqueueState: ToUninstallState instance for: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here.
	In case of theme switch, this must be done here to ensure that selection 
	in list are correctly updated according the new theme"
	self applyEnqueuedStatesFor: anElement
]

{ #category : #'instinsic state accessing' }
ToSkinStateQueue >> focused: aBoolean for: anElement [

	intrinsicState focused: aBoolean.
	self enqueueIntrinsicStateFor: anElement
]

{ #category : #initialization }
ToSkinStateQueue >> initialize [

	super initialize.
	nextStates := OrderedCollection new.
	intrinsicState := ToIntrinsicState new
]

{ #category : #accessing }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : #accessing }
ToSkinStateQueue >> resetStates [

	nextStates reset
]

{ #category : #'instinsic state accessing' }
ToSkinStateQueue >> selected: isSelected selectionOption: aSelectionOption focused: isFocused for: anElement [

	intrinsicState selectionState in: [ :selS |
			selS
				selected: isSelected;
				selectionOption: aSelectionOption;
				focused: isFocused ].
	self enqueueIntrinsicStateFor: anElement
]
