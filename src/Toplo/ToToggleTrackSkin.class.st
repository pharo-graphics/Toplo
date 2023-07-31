Class {
	#name : #ToToggleTrackSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'toggleButton'
	],
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToToggleTrackSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToBackgroundLook new
			 initialBg: [ :e |
				 toggleButton isChecked
					 ifTrue: [ e toTheme colorPrimary ]
					 ifFalse: [ e toTheme colorBgTextActive  ] ];
			 pressedBg: [ :e |
				 toggleButton isChecked
					 ifTrue: [ e toTheme colorPrimaryPressed ]
					 ifFalse: [ e toTheme colorBgTextActive ] ];
			 hoverBg: [ :e |
				 toggleButton isChecked
					 ifTrue: [ e toTheme colorPrimaryHover ]
					 ifFalse: [ e toTheme colorBgTextActive ] ];
			 yourself).
	self addLook: (ToToogleTrackLook new
			 animate: true;
			 toggleButton: toggleButton;
			 yourself).

]

{ #category : #accessing }
ToToggleTrackSkin >> toggleButton: aToggleButton [

	toggleButton := aToggleButton
]
