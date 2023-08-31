Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Pane-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToSpaceRootSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToBackgroundLook new
			 initialBg: [ :e | e toTheme backgroundColor ];
			 yourself)
]
