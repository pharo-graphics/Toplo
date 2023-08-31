Class {
	#name : #ToContextMenuDresser,
	#superclass : #ToMenuWindowDresser,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> mouseUpOutside: anEvent in: aMenuWindow [

	| origEventTarget |
	origEventTarget := anEvent originalEvent target.
	origEventTarget ifNil: [
		^ super mouseUpOutside: anEvent in: aMenuWindow ].
	(origEventTarget hasInParentChain: aMenuWindow widget) ifTrue: [
		| delay |
		" mouse up on the context menu widget, let's close the menu 
		if the delay between opening and mouse up greater than a given autoclose delay"
		delay := anEvent originalEvent timestamp - aMenuWindow popupTimestamp.
		delay > aMenuWindow autoCloseOnMouseUpDelay ifTrue: [
			^ anEvent currentTarget close ] ].
	super mouseUpOutside: anEvent in: aMenuWindow
]
