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

	^ (anElement styleSheet newLookUpdaterForPropertyName: #border)
			when: ToInitialLookEvent value: [ :e | e toTheme colorError ]; 
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ]; 
			when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ]; 
			when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
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

	^ 
		(anElement styleSheet newLookUpdaterForPropertyName: #background )
			when: ToInitialLookEvent value: [ :e | Color transparent ];
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
			yourself

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularBorderLookIn: anElement [

	^ (anElement styleSheet newLookUpdaterForPropertyName: #border )
			when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ]; 
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ]; 
			when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ]; 
			when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
			yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDefaultType new
]
