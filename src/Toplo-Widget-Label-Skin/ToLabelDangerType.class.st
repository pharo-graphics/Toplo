Class {
	#name : #ToLabelDangerType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelDangerType >> buttonLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorError ];
		  hoverColor: [ :e | e toTheme colorErrorHover ];
		  pressedColor: [ :e | e toTheme colorError darker ];
		  yourself
]

{ #category : #accessing }
ToLabelDangerType >> textColorIn: anElement [

	^ anElement toTheme colorError
]
