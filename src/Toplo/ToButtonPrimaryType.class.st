Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> iconLookIn: anElement [

	^ self regularFormLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> labelLookIn: anElement [

	^ self regularLabelLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  initialColor: anElement toTheme colorImageLightSolid;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook initialColor: anElement toTheme colorTextLightSolid.
	^ labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> whenAddedToSpace: anEvent in: anElement fromSkin: aSkin [

	super whenAddedToSpace: anEvent in: anElement fromSkin: aSkin.
	self danger
		ifTrue: [
			aSkin addLook: (ToBackgroundLook new
					 initialBg: anElement toTheme colorError;
					 pressedBg: anElement toTheme colorErrorHover darker;
					 hoverBg: anElement toTheme colorErrorHover;
					 yourself) ]
		ifFalse: [
			aSkin addLook: (ToBackgroundLook new
					 initialBg: anElement toTheme colorPrimary;
					 pressedBg: anElement toTheme colorPrimaryPressed;
					 hoverBg: anElement toTheme colorPrimaryHover;
					 yourself) ]
]
