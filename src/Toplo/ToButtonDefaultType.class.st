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
	borderLook := anElement isDisabled
		              ifTrue: [ super borderLookIn: anElement ]
		              ifFalse: [
			              self danger
				              ifTrue: [ self dangerBorderLookIn: anElement ]
				              ifFalse: [ self regularBorderLookIn: anElement ] ].
	borderLook width: [ :e | e toTheme lineWidth ].
	self dashed ifTrue: [
		borderLook dashArray: [ :e | e toTheme dashArray ] ].
	^ borderLook
]

{ #category : #accessing }
ToButtonDefaultType >> dangerBorderLookIn: anElement [

	^ ToBorderLook new
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
ToButtonDefaultType >> enabledRegularBackgroundLookIn: anElement [

	^ nil
]

{ #category : #accessing }
ToButtonDefaultType >> regularBorderLookIn: anElement [

	^ ToBorderLook new
		  initialPaint: [ :e | e toTheme colorBorder ];
		  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
		  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorPrimary ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelLookIn: anElement [

	^ ToLabelTextLook new
		  initialColor: anElement toTheme colorText;
		  hoverColor: anElement toTheme colorPrimary;
		  pressedColor: anElement toTheme colorPrimaryPressed;
		  yourself
]
