Class {
	#name : #ToDividerDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color random.
	anElement thickness: 4.
	anElement elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	anElement constraintsDo: [ :c | c ignoreByLayout ].
	anElement pane whenOrientationChangedDo: [ anElement adaptToPane ].
	anElement adaptToPane 
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]
