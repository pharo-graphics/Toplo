Class {
	#name : #ToLabelType,
	#superclass : #Object,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelType >> buttonLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorPrimary ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #accessing }
ToLabelType >> textColorIn: anElement [

	^ self subclassResponsibility 
]
