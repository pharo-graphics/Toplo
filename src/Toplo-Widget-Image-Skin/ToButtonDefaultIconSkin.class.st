Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ ToLookUpdater new 
		property: (ToPseudoProperty new 
			name: #'form-foreground'; 
			writer: [ :e :v | self adaptForegroundIn: e withColor: v] );
		when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
		when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
		when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
		when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
		yourself
]
