Class {
	#name : 'ToNoteBookPageTitleCloseButton',
	#superclass : 'ToButton',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'skin' }
ToNoteBookPageTitleCloseButton >> defaultPadding [

	^ BlInsets empty
]

{ #category : 'skin' }
ToNoteBookPageTitleCloseButton >> hoveredBorder [

	^ Color red alpha: 0.5
]
