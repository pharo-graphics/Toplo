Class {
	#name : #ToButtonDefaultType,
	#superclass : #ToButtonType,
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonDefaultType >> borderLookIn: anElement [

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

{ #category : #accessing }
ToButtonDefaultType >> dangerBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | e toTheme colorError ];
		  hoverPaint: [ :e | e toTheme colorErrorHover ];
		  pressedPaint: [ :e | e toTheme colorErrorHover darker ];
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

{ #category : #accessing }
ToButtonDefaultType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  yourself
]

{ #category : #accessing }
ToButtonDefaultType >> regularBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | e toTheme colorBorder ];
		  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
		  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorPrimary ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorPrimary ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
