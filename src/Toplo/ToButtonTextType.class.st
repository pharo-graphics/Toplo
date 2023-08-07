Class {
	#name : #ToButtonTextType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonTextType >> backgroundLookIn: anElement [

	^ nil
]

{ #category : #accessing }
ToButtonTextType >> borderLookIn: anElement [

	^ nil
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> enabledDangerBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  initialBg: [ :e | Color transparent ];
		  pressedBg: [ :e | e toTheme colorErrorBg ];
		  hoverBg: [ :e | e toTheme colorErrorBg ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> enabledRegularBackgroundLookIn: anElement [

	^ self danger
		  ifTrue: [
			  ToBackgroundLook new
				  initialBg: [:e | Color transparent];
				  pressedBg: [:e | e toTheme colorErrorBg];
				  hoverBg: [:e | e toTheme colorErrorBg];
				  yourself ]
		  ifFalse: [
			  ToBackgroundLook new
				  initialBg: [:e | Color transparent];
				  pressedBg: [:e | e toTheme colorBgTextActive];
				  hoverBg: [:e | e toTheme colorBgTextHover];
				  yourself ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularFormLookIn: anElement [

	| formLook |
	formLook := ToImageFormLook new.
	formLook
		initialColor: [ :e | e toTheme colorText];
		hoverColor: [ :e | e  toTheme colorText];
		pressedColor: [ :e | e  toTheme colorText].
	^ formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  initialColor: anElement toTheme colorText;
		  yourself
]
