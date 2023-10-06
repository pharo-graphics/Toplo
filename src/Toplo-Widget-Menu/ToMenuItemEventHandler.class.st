Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	
	target isTopMenu ifTrue: [ ^ self ].
	"target parentMenuWindow openedSubmenuWindow ifNotNil: [ :osmw |
		osmw close ]"
]
