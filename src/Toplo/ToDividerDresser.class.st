Class {
	#name : #ToDividerDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement thickness: 3.
	anElement elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	anElement constraintsDo: [ :c | c ignoreByLayout ].
	anElement pane whenOrientationChangedDo: [ anElement adaptToPane ].
	anElement adaptToPane.
	anElement addEventHandler: (ToDividerEventHandler new divider: anElement).
	anElement firstTarget when: BlElementPositionChangedEvent do: [ anElement adaptToPane ].	
	anElement secondTarget when: BlElementPositionChangedEvent do: [ anElement adaptToPane ].
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]
