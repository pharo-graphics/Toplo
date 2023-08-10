Class {
	#name : #ToToggleSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'api - accessing' }
ToToggleSkin >> childSkinsToHandle [

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
ToToggleSkin >> labelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorTextLightSolid ];
		  yourself
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

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> trackSkinIn: aButton [

	^ ToToggleTrackSkin new toggleButton: aButton
]
