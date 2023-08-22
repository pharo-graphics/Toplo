Class {
	#name : #ToMenuWindowSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToBackgroundLook new
			 initialBg: [ :e | e toTheme backgroundColor ];
			 yourself)
]
