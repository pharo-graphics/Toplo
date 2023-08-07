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
ToButtonLinkType >> enabledRegularBackgroundLookIn: anElement [

	^ nil
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  initialColor: [ :e | e toTheme colorLink ];
		  hoverColor: [ :e | e toTheme colorLinkHover ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  initialColor: anElement toTheme colorLink;
		  hoverColor: anElement toTheme colorLinkHover;
		  pressedColor: anElement toTheme colorPrimaryPressed;
		  yourself
]
