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
		  whenDisabled: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorBorderDisabled;
				  build ];
		  whenInitialized: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorError;
				  build ];
		  whenHovered: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorErrorHover;
				  build ];
		  whenPressed: [ :e |
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
		  whenDisabled: anElement toTheme colorBgContainerDisabled;
		  whenInitialized: Color transparent;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularBorderLookIn: anElement [

	^ ToBorderLook new
		  whenDisabled: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorBorderDisabled;
				  build ];
		  whenInitialized: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorBorder;
				  build ];
		  whenHovered: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorPrimaryHover;
				  build ];
		  whenPressed: [ :e |
			  (self borderBuilderIn: anElement)
				  paint: e toTheme colorPrimaryPressed;
				  build ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDefaultType new
]
