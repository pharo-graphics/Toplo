Class {
	#name : #ToButtonDefaultSkin,
	#superclass : #ToButtonSkin,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#dashed => ObservableSlot',
		'#dashedLook',
		'#labelDangerLook',
		'#iconDangerLook'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> dangerChanged [

	super dangerChanged.

]

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

	aToButtonIconChangedEvent current addLook: ToButtonImageLook new.
	self flag: 'danger off to manage here'.
	self danger ifFalse: [ ^ self ].
	iconDangerLook := ToImageDangerLook new.
	aToButtonIconChangedEvent current addLook: iconDangerLook
]

{ #category : #initialization }
ToButtonDefaultSkin >> initialize [

	super initialize.
	self whenDashedChangedDo: [ :current :previous |
		self dashedChanged ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> labelChanged: aToButtonLabelChangedEvent [

	aToButtonLabelChangedEvent current addLook: ToButtonLabelLook new.
	self flag: 'danger off to manage here'.
	self danger ifFalse: [ ^ self ].
	labelDangerLook := ToLabelDangerLook new.
	aToButtonLabelChangedEvent current addLook: labelDangerLook
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
