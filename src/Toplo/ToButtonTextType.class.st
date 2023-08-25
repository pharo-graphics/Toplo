Class {
	#name : #ToButtonTextType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'basic button' }
ToButtonTextType >> basicButtonIconSkinIn: anElement [

	^ ToButtonTextIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> dangerBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  pressedBg: [ :e | e toTheme colorErrorBg ];
		  hoverBg: [ :e | e toTheme colorErrorBg ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  pressedBg: [ :e | e toTheme colorBgTextActive ];
		  hoverBg: [ :e | e toTheme colorBgTextHover ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelTextType new
]
