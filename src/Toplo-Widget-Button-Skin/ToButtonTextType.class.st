Class {
	#name : #ToButtonTextType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonTextType >> basicButtonIconSkinIn: anElement [

	^ ToButtonTextIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> dangerBackgroundLookIn: anElement [

	^ (ToLookUpdater forProperty: (ToInstVarProperty new name: #background; yourself))
			when: ToInitialLookEvent value: [ :e | Color transparent ];
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
			when: ToPressedLookEvent value: [ :e | e toTheme colorErrorBg ];
			when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorBg ];
			yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularBackgroundLookIn: anElement [

	^ 
		(ToLookUpdater forProperty: (ToInstVarProperty new name: #background; yourself))
			when: ToInitialLookEvent value: [ :e | Color transparent ];
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
			when: ToPressedLookEvent value: [ :e | e toTheme colorBgTextActive ];
			when: ToHoveredLookEvent value: [ :e | e toTheme colorBgTextActive ];
			yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelTextType new
]
