Class {
	#name : #ToButtonLinkType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonLinkType >> backgroundLookIn: anElement [

	^ nil
]

{ #category : #accessing }
ToButtonLinkType >> borderLookIn: anElement [

	^ nil
]

{ #category : #accessing }
ToButtonLinkType >> regularBackgroundLookIn: anElement [

	^ nil
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorLink ];
		  hoverColor: [ :e | e toTheme colorLinkHover ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorLink ];
		  hoverColor: [ :e | e toTheme colorLinkHover ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
