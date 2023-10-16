Class {
	#name : 'ToNoteBookPageTitleSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self dressSelected: e ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> dressDeselected: aPageTitle [

	aPageTitle background: aPageTitle theme notebook deselectedPageTitleBackgroundColor
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> dressSelected: aPageTitle [

	aPageTitle background: aPageTitle theme notebook selectedPageTitleBackgroundColor
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: e defaultBorder.
		e background: e defaultBackground.
		e page isSelected
			ifTrue: [ self dressSelected: e ]
			ifFalse: [ self dressDeselected: e ] ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> releasedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self dressDeselected: e ]
]
