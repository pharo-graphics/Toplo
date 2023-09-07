Class {
	#name : #ToButtonDefaultType,
	#superclass : #ToClickableType,
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonDefaultType >> basicButtonBorderLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerBorderLookIn: anElement ]
		  ifFalse: [ self regularBorderLookIn: anElement ]
]

{ #category : #'basic button' }
ToButtonDefaultType >> basicButtonIconSkinIn: anElement [

	^ ToButtonDefaultIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> dangerBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorBorderDisabled;
				  build ];
		  initialStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorError;
				  build ];
		  hoverStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorErrorHover;
				  build ];
		  pressedStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorErrorHover darker;
				  build ];
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
		  disabledStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorBorderDisabled;
				  build ];
		  initialStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorBorder;
				  build ];
		  hoverStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorPrimaryHover;
				  build ];
		  pressedStateValue: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorPrimaryPressed;
				  build ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDefaultType new
]
