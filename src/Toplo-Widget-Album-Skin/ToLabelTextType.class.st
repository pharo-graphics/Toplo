Class {
	#name : #ToLabelTextType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelTextType >> buttonLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  yourself
]

{ #category : #accessing }
ToLabelTextType >> textColorIn: anElement [

	^ anElement toTheme colorText
]
