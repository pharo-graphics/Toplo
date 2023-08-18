Class {
	#name : #ToToggleButtonSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'api - accessing' }
ToToggleButtonSkin >> childSkinsToHandle [

	^ {
		  (ToChildSkin new
			   slotName: #icon;
			   skinBuilder: [ :e | self trackSkinIn: e ];
			   yourself).
		  (ToChildSkin new
			   slotName: #label;
			   skinBuilder: [ :e | self labelSkinIn: e ];
			   yourself) }
]

{ #category : #accessing }
ToToggleButtonSkin >> labelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorTextLightSolid ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonSkin >> labelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new.

]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	anElement hFitContent.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal)
	" setup the track "
	"anElement track withSkin: (ToToggleTrackSkin new toggleButton: anElement)"
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonSkin >> trackSkinIn: aButton [

	^ ToToggleTrackSkin new
]
