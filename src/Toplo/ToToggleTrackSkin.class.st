Class {
	#name : #ToToggleTrackSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'toggleButton'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToToggleTrackSkin >> toggleButton: aToggleButton [

	toggleButton := aToggleButton
]

{ #category : #'api - install/uninstall  hook' }
ToToggleTrackSkin >> whenAddedToSpace: anEvent in: anElement [

	toggleButton := anElement parent.
	self addLook: (ToBackgroundLook new
				  initialBg: [:e | toggleButton isChecked ifTrue: [ e toTheme colorPrimary ] ifFalse: [ e toTheme colorBgTextActive ]];
				  pressedBg: [:e | toggleButton isChecked ifTrue: [ e toTheme colorPrimaryPressed] ifFalse: [ e toTheme colorBgTextActive muchDarker]];
				  hoverBg: [:e | toggleButton isChecked ifTrue: [ e toTheme colorPrimaryHover] ifFalse: [e toTheme colorBgTextActive darker]];
				  yourself).
	self addLook: (ToToogleTrackLook new animate: true; toggleButton: toggleButton; yourself).
	super whenAddedToSpace: anEvent in: anElement
]
