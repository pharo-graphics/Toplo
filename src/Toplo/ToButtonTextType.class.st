Class {
	#name : #ToButtonTextType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonTextType >> backgroundLookIn: anElement [

	^ nil
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
ToButtonTextType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorText ];
		  pressedColor: [ :e | e toTheme colorText ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  yourself
]
