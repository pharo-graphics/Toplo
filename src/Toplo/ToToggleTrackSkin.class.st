Class {
	#name : #ToToggleTrackSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'toggleButton'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToToggleTrackSkin >> toggleButton [

	^ toggleButton
]

{ #category : #accessing }
ToToggleTrackSkin >> toggleButton: aToggleButton [

	toggleButton := aToggleButton
]

{ #category : #'api - install/uninstall  hook' }
ToToggleTrackSkin >> whenAddedToSpace: anEvent in: anElement [

	self addLook: (ToBackgroundLook new
				  initialBg: [:e | self toggleButton isChecked ifTrue: [ e toTheme colorPrimary ] ifFalse: [ e toTheme colorBgTextActive ]];
				  pressedBg: [:e | self toggleButton isChecked ifTrue: [ e toTheme colorPrimaryPressed] ifFalse: [ e toTheme colorBgTextActive muchDarker]];
				  hoverBg: [:e | self toggleButton isChecked ifTrue: [ e toTheme colorPrimaryHover] ifFalse: [e toTheme colorBgTextActive darker]];
				  yourself).
	self addLook: ToToogleTrackLook new.
	super whenAddedToSpace: anEvent in: anElement
]
