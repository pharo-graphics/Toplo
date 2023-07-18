Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> backgroundLookIn: anElement [

	^ self danger
		  ifTrue: [
			  ToBackgroundLook new
				  initialBg: [:e | e toTheme colorError];
				  pressedBg: [:e | e toTheme colorErrorHover darker];
				  hoverBg: [:e | e toTheme colorErrorHover];
				  yourself ]
		  ifFalse: [
			  ToBackgroundLook new
				  initialBg: [:e | e toTheme colorPrimary];
				  pressedBg: [:e | e toTheme colorPrimaryPressed];
				  hoverBg: [:e | e toTheme colorPrimaryHover];
				  yourself ]
]

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
