Class {
	#name : #ToLabelLinkType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelLinkType >> buttonLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorLink ];
		  hoverColor: [ :e | e toTheme colorLinkHover ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #accessing }
ToLabelLinkType >> textColorIn: anElement [

	^ anElement toTheme colorLink
]
