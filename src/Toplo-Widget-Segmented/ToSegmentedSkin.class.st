Class {
	#name : #ToSegmentedSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToSegmentedSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (Color fromHexString: 'f5f5f5').
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-XS')) ]
]
