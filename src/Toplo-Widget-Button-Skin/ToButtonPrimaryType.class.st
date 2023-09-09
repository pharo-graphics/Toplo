Class {
	#name : #ToButtonPrimaryType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonPrimaryType >> basicButtonBorderLookIn: anElement [

	^ ToBorderLook new
		  whenDisabled: [ :e | e toTheme colorBorderDisabled ];
		  whenInitialized: [ :e | Color transparent ];
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

	^ ToBackgroundLook new
		  whenInitialized: anElement toTheme colorError;
		  whenDisabled: anElement toTheme colorBgContainerDisabled;
		  whenPressed: (anElement toTheme colorErrorPressed  );
		  whenHovered: (anElement toTheme colorErrorHover  );
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  whenInitialized: anElement toTheme colorPrimary;
		  whenDisabled: anElement toTheme colorBgContainerDisabled;
		  whenPressed: (ToStateUpdater new value: anElement toTheme colorPrimaryPressed; duration: 200 milliSeconds; yourself);
		  whenHovered: (ToStateUpdater new value: anElement toTheme colorPrimaryHover; duration: 200 milliSeconds; yourself);
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelPrimaryType new
]
