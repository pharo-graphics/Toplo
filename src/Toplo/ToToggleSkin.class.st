Class {
	#name : #ToToggleSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> iconSkinIn: aButton [

	^ ToToggleTrackSkin new toggleButton: aButton
]

{ #category : #accessing }
ToToggleSkin >> labelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook initialColor: anElement toTheme colorTextLightSolid.
	^ labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> labelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new.

]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
	" setup the track "
	"anElement track withSkin: (ToToggleTrackSkin new toggleButton: anElement)"
]
