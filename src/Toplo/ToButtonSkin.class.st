Class {
	#name : #ToButtonSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'type',
		'cursorLook'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'accessing - structure variables' }
ToButtonSkin class >> type: aButtonType [

	^ self new type: aButtonType 
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

	^ ToButtonIconSkin new buttonSkin: self.

]

{ #category : #accessing }
ToButtonSkin >> labelLookIn: anElement [

	^ self type labelLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> labelSkinIn: aButton [

	^ ToButtonLabelSkin new buttonSkin: self.

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self type onSkinInstalled: self in: anElement.
	cursorLook := ToMouseCursorLook new.
	cursorLook hoverCursor: [ :but | but isEnabled ifTrue: [ BlCursor hand ] ifFalse: []].
	self addLook: cursorLook.


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinUninstalledIn: anElement [

	self type onSkinUninstalled: self in: anElement.
	self removeLook: cursorLook.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToButtonSkin >> type [

	"#default, #primary, #link or #text"

	^ type ifNil: [ type := ToButtonDefaultType new ]
]

{ #category : #accessing }
ToButtonSkin >> type: aSkinType [

	"#default, #primary, #link or #text"
	type := aSkinType
]
