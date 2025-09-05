Class {
	#name : #ToSkinStateQueue,
	#superclass : #Object,
	#instVars : [
		'nextStates',
		'installStateApplied',
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
	
	installState ifNotNil: [ ^ self ].
	installState := ToInstallState instance.
	self enqueueState: installState for: anElement.
	intrinsicState enabled: anElement isEnabled.
	self enqueueState: intrinsicState for: anElement.
	intrinsicState enqueued: true
]

{ #category : #adding }
ToSkinStateQueue >> enqueueIntrinsicStateFor: anElement [

	(anElement isAttachedToSceneGraph not or: [ installStateApplied not ])
		ifTrue: [ ^ anElement requestNewSkin ].
	intrinsicState enqueued ifTrue: [ ^ self ].
	self enqueueState: intrinsicState for: anElement.
	intrinsicState enqueued: true
]

{ #category : #adding }
ToSkinStateQueue >> enqueueState: aState for: anElement [

	nextStates add: aState.
	anElement spaceDo: [ :sp | sp needSkinStateApplicationPass: true ]
]

{ #category : #adding }
ToSkinStateQueue >> enqueueTransientState: aState for: anElement [
	" all states kinds are enqueued here "

	installState ifNil: [ ^ self ].
	(anElement isPreventedSkinEvent: aState skinEvent) ifTrue: [ ^ self ].
	self enqueueState: aState for: anElement
]

{ #category : #adding }
ToSkinStateQueue >> enqueueUninstallStateFor: anElement [
	" uninstall state required  "

	" have to ignore previous skin events to avoid to apply them to the new skin"
	nextStates reset.
	installState := nil.
	" store the uninstall state "
	self enqueueState: ToUninstallState instance for: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here "
	self applyEnqueuedStatesFor: anElement
]

{ #category : #'instinsic state accessing' }
ToSkinStateQueue >> focused: aBoolean for: anElement [
	" Do not force state application if the element is not in a space.
	It can also be the case when a layout is computed for an infinite "

	intrinsicState focused: aBoolean.
	self enqueueIntrinsicStateFor: anElement
]

{ #category : #testing }
ToSkinStateQueue >> hasInstallStateEnqueued [

	^ installState notNil
]

{ #category : #initialization }
ToSkinStateQueue >> initialize [ 

	super initialize.
	installStateApplied := false.
	nextStates := OrderedCollection new.
	intrinsicState := ToIntrinsicState new
]

{ #category : #'state application' }
ToSkinStateQueue >> installStateApplied: aBoolean [

	installStateApplied := aBoolean
]

{ #category : #accessing }
ToSkinStateQueue >> nextStates [

	^ nextStates
]

{ #category : #'instinsic state accessing' }
ToSkinStateQueue >> selected: isSelected selectionOption: aSelectionOption focused: isFocused for: anElement [

	intrinsicState selected: isSelected.
	intrinsicState selectionOption: aSelectionOption.
	intrinsicState focused: isFocused.
	self enqueueIntrinsicStateFor: anElement
]
