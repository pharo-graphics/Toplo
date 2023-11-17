Class {
	#name : 'ToNotebookPageInnerCloseButtonSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNotebookPageInnerCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: (Color red alpha: 0.5) ]
]

{ #category : 'event handling' }
ToNotebookPageInnerCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | e padding: BlInsets empty ]
]
