Class {
	#name : #ToButtonDefaultType,
	#superclass : #ToClickableType,
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> basicButtonBorderLookIn: anElement [

	| borderLook |
	borderLook := self danger
		              ifTrue: [ self dangerBorderLookIn: anElement ]
		              ifFalse: [ self regularBorderLookIn: anElement ].
	self dashed ifTrue: [
		borderLook dashArray: [ :e | e toTheme dashArray ] ].
	^ borderLook
]

{ #category : #'basic button' }
ToButtonDefaultType >> basicButtonIconSkinIn: anElement [

	^ ToButtonDefaultIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> dangerBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledStateValue: [ :e | e toTheme colorBorderDisabled ];
		  initialStateValue: [ :e | e toTheme colorError ];
		  hoverStateValue: [ :e | e toTheme colorErrorHover ];
		  pressedStateValue: [ :e | e toTheme colorErrorHover darker ];
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
		  disabledStateValue: anElement toTheme colorBgContainerDisabled;
		  initialStateValue: Color transparent;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledStateValue: [ :e | e toTheme colorBorderDisabled ];
		  initialStateValue: [ :e | e toTheme colorBorder ];
		  hoverStateValue: [ :e | e toTheme colorPrimaryHover ];
		  pressedStateValue: [ :e | e toTheme colorPrimaryPressed ];
		  width: [ :e | e toTheme lineWidth ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDefaultType new
]
