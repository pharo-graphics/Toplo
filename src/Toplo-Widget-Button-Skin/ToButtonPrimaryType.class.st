Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonPrimaryType >> basicButtonBorderLookIn: anElement [

	^ (ToLookUpdater forProperty: (ToInstVarProperty new name: #border; yourself))
			when: ToInitialLookEvent value: [ :e | Color transparent ]; 
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ]; 
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

	^ 
		(ToLookUpdater forProperty: (ToInstVarProperty new name: #background; yourself))
			when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
			when: ToPressedLookEvent value: [ :e | e toTheme colorErrorPressed ];
			when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
			yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularBackgroundLookIn: anElement [

	^ (ToLookUpdater forProperty: (ToInstVarProperty new name: #background; yourself))
			when: ToInitialLookEvent value: [ :e | e toTheme colorPrimary ];
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
			when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
			when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
			yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelPrimaryType new
]
