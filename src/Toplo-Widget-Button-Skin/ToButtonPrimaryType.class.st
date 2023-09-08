Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonPrimaryType >> basicButtonBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledValue: [ :e | e toTheme colorBorderDisabled ];
		  initialValue: [ :e | Color transparent ];
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
		  initialValue: anElement toTheme colorError;
		  disabledValue: anElement toTheme colorBgContainerDisabled;
		  pressedValue: (anElement toTheme colorErrorPressed asStateValue duration: 200 milliSeconds; yourself);
		  hoveredValue: (anElement toTheme colorErrorHover asStateValue duration: 200 milliSeconds; yourself);
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  initialValue: anElement toTheme colorPrimary;
		  disabledValue: anElement toTheme colorBgContainerDisabled;
		  pressedValue: (ToStateValue new value: anElement toTheme colorPrimaryPressed; duration: 200 milliSeconds; yourself);
		  hoveredValue: (ToStateValue new value: anElement toTheme colorPrimaryHover; duration: 200 milliSeconds; yourself);
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelPrimaryType new
]
