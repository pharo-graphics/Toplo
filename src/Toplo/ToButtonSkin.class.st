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

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> buttonIconChanged: anEvent [

	anEvent currentTarget icon ifNil: [ ^ self ].
	anEvent currentTarget icon withSkin: (ToButtonIconSkin new buttonSkin: self)
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> buttonLabelChanged: anEvent [

	anEvent currentTarget label ifNil: [ ^ self ].
	anEvent currentTarget label withSkin: (ToButtonLabelSkin new buttonSkin: self).

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

{ #category : #'api - accessing' }
ToButtonSkin >> eventsToHandle [ 

	^ super eventsToHandle, { ToButtonIconChangedEvent. ToButtonLabelChangedEvent }
]

{ #category : #accessing }
ToButtonSkin >> iconLookIn: anElement [

	^ self type iconLookIn: anElement
]

{ #category : #accessing }
ToButtonSkin >> labelLookIn: anElement [

	^ self type labelLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinInstalledIn: anElement [

	" must send to super ** after ** the look is initialize from type "
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
