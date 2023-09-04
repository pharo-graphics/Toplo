Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Pane-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToSpaceRootSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToBackgroundColorLook new
			 initialColor: [ :e | e toTheme backgroundColor ];
			 yourself)
]
