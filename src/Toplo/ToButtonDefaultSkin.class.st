Class {
	#name : #ToButtonDefaultSkin,
	#superclass : #ToButtonSkin,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#dashed => ObservableSlot',
		'#dashedLook'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToButtonDefaultSkin >> dashed [

	^ dashed ifNil: [ dashed := false ]
]

{ #category : #accessing }
ToButtonDefaultSkin >> dashed: aBoolean [

	dashed := aBoolean
]

{ #category : #accessing }
ToButtonDefaultSkin >> dashedChanged [

	lookEventHandler ifNil: [ ^ self ].
	dashed ifTrue: [
		dashedLook := ToButtonDashedLook new.
		^ self addLook: dashedLook ].
	self removeLook: dashedLook.
	dashedLook := nil
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> iconChanged: aToButtonIconChangedEvent [

	aToButtonIconChangedEvent current addLook: ToButtonImageLook new
]

{ #category : #initialization }
ToButtonDefaultSkin >> initialize [

	self class initializeSlots: self.
	super initialize.
	self whenDashedChangedDo: [ :current :previous |
		self dashedChanged ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> labelChanged: aToButtonLabelChangedEvent [

	aToButtonLabelChangedEvent current addLook: ToButtonLabelLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> mainLookIn: anElement [

	^ ToButtonDefaultLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self dashed ifFalse: [ ^ self ].
	dashedLook := ToButtonDashedLook new.
	self addLook: dashedLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #accessing }
ToButtonDefaultSkin >> whenDashedChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #dashed whenChangedDo: aBlock
]
