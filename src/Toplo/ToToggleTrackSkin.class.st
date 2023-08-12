Class {
	#name : #ToToggleTrackSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToToggleTrackSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToBackgroundLook new
			 initialBg: [ :e |
				 anElement isChecked
					 ifTrue: [ e toTheme colorBgContainerChecked ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked  ] ];
			 pressedBg: [ :e |
				 anElement isChecked
					 ifTrue: [ e toTheme colorBgContainerCheckedPressed ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked ] ];
			 hoverBg: [ :e |
				 anElement isChecked
					 ifTrue: [ e toTheme colorBgContainerCheckedHover ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked ] ];
			 yourself).
	self addLook: (ToToogleTrackLook new
			 animate: true;
			 yourself).

]
