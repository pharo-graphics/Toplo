Class {
	#name : #ToLabelPrimaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelPrimaryType >> buttonLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e  toTheme colorTextDisabled];
		  initialColor: [ :e | e  toTheme colorTextLightSolid];
		  yourself
]

{ #category : #accessing }
ToLabelPrimaryType >> textColorIn: anElement [

	^  anElement toTheme colorTextLightSolid
]
