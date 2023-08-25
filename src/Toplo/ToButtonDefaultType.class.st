Class {
	#name : #ToButtonDefaultType,
	#superclass : #ToClickableType,
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> basicButtonBorderLookIn: anElement [

	| borderLook |
	borderLook := self danger
		              ifTrue: [ self dangerBorderLookIn: anElement ]
		              ifFalse: [ self regularBorderLookIn: anElement ].
	borderLook ifNotNil: [ 
		borderLook width: [ :e | e toTheme lineWidth ].
		self dashed ifTrue: [
			borderLook dashArray: [ :e | e toTheme dashArray ] ] ].
	^ borderLook
]

{ #category : #'basic button' }
ToButtonDefaultType >> basicButtonIconSkinIn: anElement [

	^ ToButtonDefaultIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> dangerBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | e toTheme colorError ];
		  hoverPaint: [ :e | e toTheme colorErrorHover ];
		  pressedPaint: [ :e | e toTheme colorErrorHover darker ];
		  width: [ :e | e toTheme lineWidth ];
		  yourself
]

{ #category : #accessing }
ToButtonDefaultType >> dashed [

	^ dashed ifNil: [ dashed := false ]
]

{ #category : #accessing }
ToButtonDefaultType >> dashed: aBoolean [

	dashed := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | e toTheme colorBorder ];
		  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
		  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
		  width: [ :e | e toTheme lineWidth ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDefaultType new
]
