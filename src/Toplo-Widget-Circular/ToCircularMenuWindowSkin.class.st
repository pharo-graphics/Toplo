Class {
	#name : #ToCircularMenuWindowSkin,
	#superclass : #ToBasicWindowElementSkin,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'event handling' }
ToCircularMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	" ***  notice that the background should be transparent. 
	The background should be set in the node containers "
	anEvent elementDo: [ :e | 
			e background: Color transparent.
			e border: BlBorder empty.
			e padding: BlInsets empty.
			e geometry: BlCircleGeometry new ]
]
