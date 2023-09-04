Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> basicButtonBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | Color transparent ];
		  width: [ :e | e toTheme lineWidth ];
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

	^ ToBackgroundColorLook new
		  initialColor: [ :e | e toTheme colorError ];
		  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
		  pressedColor: [ :e | e toTheme colorErrorPressed ];
		  hoverColor: [ :e | e toTheme colorErrorHover ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundColorLook new
		  initialColor: [ :e | e toTheme colorPrimary ];
		  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  hoverColor: [ :e | e toTheme colorPrimaryHover ];
		  duration: 200 milliSeconds;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelPrimaryType new
]
