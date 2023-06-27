Class {
	#name : #ToContextMenuDresser,
	#superclass : #ToMenuWindowDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> mouseOutside: anEvent in: aMenuWindow [

	| origEventTarget |
	origEventTarget := anEvent originalEvent currentTarget.
	origEventTarget ifNil: [ ^ super mouseOutside: anEvent in: aMenuWindow].
	(origEventTarget hasInParentChain: aMenuWindow widget) ifTrue: [ 
		" mouse down on the context menu widget, let's close the menu "
		^ anEvent currentTarget close ].
	super mouseOutside: anEvent in: aMenuWindow
]
