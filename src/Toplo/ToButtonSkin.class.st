Class {
	#name : #ToButtonSkin,
	#superclass : #ToControlSkin,
	#instVars : [
		'type'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'accessing - structure variables' }
ToButtonSkin class >> type: aButtonType [

	^ self new type: aButtonType 
]

{ #category : #accessing }
ToButtonSkin >> changeTypeWith: aSkinType in: anElement [

	"DefaultType, PrimaryType, LinkType or TextType "
	self type: aSkinType.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - accessing' }
ToButtonSkin >> childSkinsToHandle [

	^ {
		  (ToChildSkin new
			   slotName: #icon;
			   skinBuilder: [ :e | self iconSkinIn: e ];
			   yourself).
		  (ToChildSkin new
			   slotName: #label;
			   skinBuilder: [ :e | self labelSkinIn: e ];
			   yourself) }
]

{ #category : #accessing }
ToButtonSkin >> danger [

	^ self type danger
]

{ #category : #accessing }
ToButtonSkin >> danger: aBoolean [

	self type danger: aBoolean
]

{ #category : #accessing }
ToButtonSkin >> dashed [

	^ self type dashed
]

{ #category : #accessing }
ToButtonSkin >> dashed: aBoolean [

	self type dashed: aBoolean
]

{ #category : #accessing }
ToButtonSkin >> iconLookIn: anElement [

	^ self type iconLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> iconSkinIn: aButton [

	^ ToButtonIconSkin new buttonType: self type.

]

{ #category : #accessing }
ToButtonSkin >> labelLookIn: anElement [

	^ self type labelLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> labelSkinIn: aButton [

	^ ToButtonLabelSkin new buttonType: self type.

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self type onSkinInstalled: self in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinUninstalledIn: anElement [

	self type onSkinUninstalled: self in: anElement.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToButtonSkin >> type [

	"#default, #primary, #link or #text"

	^ type ifNil: [ type := ToButtonDefaultType new ]
]

{ #category : #accessing }
ToButtonSkin >> type: aSkinType [

	"DefaultType, PrimaryType, LinkType or TextType "
	type := aSkinType
]
