Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Pane-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToSpaceRootSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToLook new applyWith: [ :e :v | e background: v asBlBackground ];
			 initialValue: anElement toTheme backgroundColor;
			 yourself)
]
