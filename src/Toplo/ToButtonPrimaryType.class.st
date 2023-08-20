Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
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

	^ ToBackgroundLook new
		  initialBg: [ :e | e toTheme colorError ];
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  pressedBg: [ :e | e toTheme colorErrorPressed ];
		  hoverBg: [ :e | e toTheme colorErrorHover ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  initialBg: [ :e | e toTheme colorPrimary ];
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  pressedBg: [ :e | e toTheme colorPrimaryPressed ];
		  hoverBg: [ :e | e toTheme colorPrimaryHover ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelPrimaryType new
]
