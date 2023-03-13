Class {
	#name : #ToDividerDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement thickness: 4.
	anElement elevation:
		(BlRelativeElevation elevation: SmallInteger maxVal).
	anElement constraintsDo: [ :c | c ignoreByLayout ].
	anElement isVertical
		ifTrue: [
			anElement
				vMatchParent;
				width: anElement thickness.
			anElement constraintsDo: [ :c | c ignored vertical alignTop ] ]
		ifFalse: [
			anElement
				hMatchParent;
				height: anElement thickness.
			anElement constraintsDo: [ :c | c ignored horizontal alignLeft ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]
