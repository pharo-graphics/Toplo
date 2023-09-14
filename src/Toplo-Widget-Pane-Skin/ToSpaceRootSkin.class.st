Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Pane-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToSpaceRootSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLookUpdater: ((anElement toTheme styleSheet newLookUpdaterForPropertyName: #background)
			 when: ToInstallLookEvent value: anElement toTheme backgroundColor;
			 yourself)
]
