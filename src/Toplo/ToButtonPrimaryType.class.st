Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> borderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | Color transparent ];
		  width: [ :e | e toTheme lineWidth ];
		  yourself
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
ToButtonPrimaryType >> iconLookIn: anElement [

	^ self regularFormLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> labelLookIn: anElement [

	^ self regularLabelLookIn: anElement
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
ToButtonPrimaryType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorImageLightSolid ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e  toTheme colorTextDisabled];
		  initialColor: [ :e | e  toTheme colorTextLightSolid];
		  yourself
]
