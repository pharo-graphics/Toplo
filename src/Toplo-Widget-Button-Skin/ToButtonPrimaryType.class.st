Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonPrimaryType >> basicButtonBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledStateValue: [ :e | e toTheme colorBorderDisabled ];
		  initialStateValue: [ :e | Color transparent ];
		  yourself
]

{ #category : #'basic button' }
ToButtonPrimaryType >> basicButtonIconSkinIn: anElement [

	^ ToButtonPrimaryIconSkin new danger: self danger
]

{ #category : #'basic button' }
ToButtonPrimaryType >> basicButtonLabelSkinIn: anElement [

	^ self regularLabelSkinIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> dangerBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  initialStateValue: anElement toTheme colorError;
		  disabledStateValue: anElement toTheme colorBgContainerDisabled;
		  pressedStateValue: (anElement toTheme colorErrorPressed asStateValue duration: 200 milliSeconds; yourself);
		  hoverStateValue: (anElement toTheme colorErrorHover asStateValue duration: 200 milliSeconds; yourself);
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  initialStateValue: anElement toTheme colorPrimary;
		  disabledStateValue: anElement toTheme colorBgContainerDisabled;
		  pressedStateValue: (ToStateValue new value: anElement toTheme colorPrimaryPressed; duration: 200 milliSeconds; yourself);
		  hoverStateValue: (ToStateValue new value: anElement toTheme colorPrimaryHover; duration: 200 milliSeconds; yourself);
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelPrimaryType new
]
